#!/bin/zsh
# tmux-claude-gather.sh
# Claude Code ペインを一か所に集めたり、元の場所に戻したりするスクリプト
#
# Usage:
#   tmux-claude-gather.sh [gather|disperse|toggle]
#   引数なし or toggle: gather/disperse を自動切り替え
#
# tmux.conf でのキーバインド例:
#   bind g run-shell "~/dotfiles/.bin/tmux-claude-gather.sh"

GATHER_WINDOW_NAME="claude-gather"
STATE_FILE="${XDG_RUNTIME_DIR:-${TMPDIR:-/tmp}}/tmux-claude-gather.state"
MAX_PER_ROW=4

die() { echo "Error: $*" >&2; exit 1 }

check_tmux() {
    [[ -n "${TMUX:-}" ]] || die "tmux セッション内で実行してください"
}

detect_claude_panes() {
    tmux list-panes -a \
        -F "#{pane_id} #{session_name} #{window_index} #{window_name} #{pane_tty}" \
    | while read -r pane_id session win_idx win_name tty; do
        [[ "$win_name" == "$GATHER_WINDOW_NAME" ]] && continue
        # TTY 上で動いているプロセスのコマンドライン全体に "claude" が含まれるか確認
        # pane_current_command (node 等) ではなく実際のプロセス引数を見る
        if ps -o args= -t "$tty" 2>/dev/null | grep -q "claude"; then
            echo "$pane_id $session $win_idx $win_name"
        fi
    done
}

gather() {
    [[ -f "$STATE_FILE" ]] && die "すでに集まっています。disperse を実行してください:\n  $0 disperse"

    local panes
    panes=$(detect_claude_panes)
    [[ -n "$panes" ]] || die "Claude Code ペインが見つかりません"

    local count
    count=$(echo "$panes" | wc -l | tr -d ' ')
    local session
    session=$(tmux display-message -p "#{session_name}")

    # ペインを移動する前に各ウィンドウのレイアウトを保存
    local pane_id pane_session win_idx win_name win_key layout
    local -a saved_windows=()

    while IFS= read -r line; do
        pane_id=$(echo "$line" | awk '{print $1}')
        pane_session=$(echo "$line" | awk '{print $2}')
        win_idx=$(echo "$line" | awk '{print $3}')
        win_name=$(echo "$line" | awk '{print $4}')

        echo "PANE $pane_id $pane_session $win_idx $win_name" >> "$STATE_FILE"
        # 元ウィンドウ名をペインユーザー変数に記録（border-format で参照するため）
        tmux set-option -p -t "$pane_id" @origin_win "$win_name"

        win_key="$pane_session:$win_idx"
        if [[ ! " ${saved_windows[@]} " =~ " $win_key " ]]; then
            layout=$(tmux list-windows -t "$pane_session" \
                -F "#{window_index} #{window_layout}" \
                | awk -v idx="$win_idx" '$1 == idx {print $2}')
            echo "LAYOUT $pane_session $win_idx $layout" >> "$STATE_FILE"
            saved_windows+=("$win_key")
        fi
    done <<< "$panes"

    # gather ウィンドウを作成
    tmux new-window -t "$session" -n "$GATHER_WINDOW_NAME"
    local top_anchor
    top_anchor=$(tmux display-message -p -t "$session:$GATHER_WINDOW_NAME" "#{pane_id}")

    # このウィンドウだけペインタイトルを表示（グローバル設定を上書き）
    tmux set-window-option -t "$session:$GATHER_WINDOW_NAME" pane-border-status bottom
    tmux set-window-option -t "$session:$GATHER_WINDOW_NAME" pane-border-format "[#{@origin_win}] #{pane_title}"

    # 5つ以上のペインがある場合は上下2行の骨格を作る
    local bottom_anchor=""
    if (( count > MAX_PER_ROW )); then
        tmux split-window -v -t "$top_anchor"
        bottom_anchor=$(tmux display-message -p -t "$session:$GATHER_WINDOW_NAME" "#{pane_id}")
    fi

    # ペインIDを配列に取得して振り分けながら join（行ごとに追跡）
    local -a pane_ids top_row_panes bottom_row_panes
    pane_ids=(${(f)"$(grep "^PANE " "$STATE_FILE" | awk '{print $2}')"})

    local i p
    for (( i=1; i<=${#pane_ids}; i++ )); do
        p="${pane_ids[$i]}"
        if (( i <= MAX_PER_ROW )); then
            tmux join-pane -h -s "$p" -t "$top_anchor"
            top_row_panes+=("$p")
        else
            tmux join-pane -h -s "$p" -t "$bottom_anchor"
            bottom_row_panes+=("$p")
        fi
    done

    # アンカーペイン（空のシェル）を削除
    tmux kill-pane -t "$top_anchor" 2>/dev/null || true
    [[ -n "$bottom_anchor" ]] && tmux kill-pane -t "$bottom_anchor" 2>/dev/null || true

    # 幅を均等化
    # join-pane は anchor の幅を毎回半分にするため join 順のままでは不均等になる
    # → 実際の表示位置 (pane_left, pane_top) でソートしてから左→右順にリサイズ
    local win_width win_height
    win_width=$(tmux display-message -p -t "$session:$GATHER_WINDOW_NAME" "#{window_width}")
    win_height=$(tmux display-message -p -t "$session:$GATHER_WINDOW_NAME" "#{window_height}")

    if (( count <= MAX_PER_ROW )); then
        tmux select-layout -t "$session:$GATHER_WINDOW_NAME" even-horizontal
    else
        # ペインを (pane_top, pane_left) の順でソートして上段・下段に分類
        local -a top_ordered=() bot_ordered=()
        local mid_y=$(( win_height / 2 ))
        local _pid _pleft _ptop
        while IFS=' ' read -r _pid _pleft _ptop; do
            if (( _ptop < mid_y )); then
                top_ordered+=("$_pid")
            else
                bot_ordered+=("$_pid")
            fi
        done < <(tmux list-panes -t "$session:$GATHER_WINDOW_NAME" \
            -F "#{pane_id} #{pane_left} #{pane_top}" | sort -k3 -n -k2 -n)

        # 左→右の順でリサイズ（最右端は自動でスペースを埋める）
        local top_w=$(( win_width / ${#top_ordered} ))
        for (( i=1; i<${#top_ordered}; i++ )); do
            tmux resize-pane -t "${top_ordered[$i]}" -x "$top_w" 2>/dev/null || true
        done
        if (( ${#bot_ordered} > 0 )); then
            local bot_w=$(( win_width / ${#bot_ordered} ))
            for (( i=1; i<${#bot_ordered}; i++ )); do
                tmux resize-pane -t "${bot_ordered[$i]}" -x "$bot_w" 2>/dev/null || true
            done
        fi
    fi

    tmux select-window -t "$session:$GATHER_WINDOW_NAME"
    # tmux display-message "集まれー！ $count 個の Claude Code ペインを '$GATHER_WINDOW_NAME' に集めました"
}

disperse() {
    [[ -f "$STATE_FILE" ]] || die "状態ファイルがありません。gather を実行してください:\n  $0 gather"

    local session
    session=$(tmux display-message -p "#{session_name}")
    local count=0
    local pane_id pane_session win_idx win_name target new_idx layout

    # ペインを元のウィンドウに戻す
    while IFS= read -r line; do
        pane_id=$(echo "$line" | awk '{print $2}')
        pane_session=$(echo "$line" | awk '{print $3}')
        win_idx=$(echo "$line" | awk '{print $4}')
        win_name=$(echo "$line" | awk '{print $5}')

        if ! tmux display-message -p -t "$pane_id" "#{pane_id}" 2>/dev/null | grep -q "^$pane_id$"; then
            echo "警告: ペイン $pane_id は存在しません。スキップします。" >&2
            continue
        fi

        target="$pane_session:$win_idx"

        if ! tmux list-windows -t "$pane_session" -F "#{window_index}" 2>/dev/null | grep -q "^$win_idx$"; then
            tmux new-window -t "$pane_session:" -n "$win_name"
            new_idx=$(tmux list-windows -t "$pane_session" -F "#{window_index} #{window_name}" \
                | awk -v name="$win_name" '$2 == name {print $1}' | tail -1)
            target="$pane_session:$new_idx"
        fi

        tmux join-pane -s "$pane_id" -t "$target"
        count=$((count + 1))
    done < <(grep "^PANE " "$STATE_FILE")

    tmux kill-window -t "$session:$GATHER_WINDOW_NAME" 2>/dev/null || true

    # 保存していたレイアウトを復元
    while IFS= read -r line; do
        pane_session=$(echo "$line" | awk '{print $2}')
        win_idx=$(echo "$line" | awk '{print $3}')
        layout=$(echo "$line" | awk '{print $4}')
        tmux select-layout -t "$pane_session:$win_idx" "$layout" 2>/dev/null || true
    done < <(grep "^LAYOUT " "$STATE_FILE")

    rm -f "$STATE_FILE"
    # tmux display-message "解散！ $count 個のペインを元の場所に戻しました"
}

check_tmux

case "${1:-toggle}" in
    gather)   gather ;;
    disperse) disperse ;;
    toggle)
        if [[ -f "$STATE_FILE" ]]; then
            disperse
        else
            gather
        fi
        ;;
    *)
        echo "Usage: $0 [gather|disperse|toggle]"
        echo "  gather:   Claude Code ペインを '$GATHER_WINDOW_NAME' に集める"
        echo "  disperse: 集めたペインを元の場所に戻す"
        echo "  toggle:   gather/disperse を自動切り替え (デフォルト)"
        echo ""
        echo "  検出: 各ペインの TTY 上のプロセス引数に 'claude' が含まれるか確認"
        exit 1
        ;;
esac
