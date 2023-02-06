#!/bin/zsh

# セッションの名前
SESSION_NAME=config

# ワークスペースの数
WORKSPACE_COUNT=5

# ワークスペース(タブ)の名前
WORKSPACE_NAME=(
  neovim
  yabai
  alacritty
  tmux
  dotfiles
)

# ワークスペースのパス
WORKSPACE_PATH=(
  ~/.config/nvim/
  ~/.config/yabai/
  ~/.config/alacritty/
  ~/.config/tmux/
  ~/dotfiles/
)

# ワークスペースのタブの色
WORKSPACE_COLOR=(
  "#9a348e"
  "#da627d"
  "#fca17d"
  "#86bbd8"
  "#06969A"
  "#33658a"
)

# 色付きタブのフォーマットを生成
WINDOW_STATUS_FORMAT="#[bg=#ffffff,fg=#dddddd]#{?#{!=:#W,"$WORKSPACE_NAME[1]"},▏, }"
WINDOW_STATUS_CURRENT_FORMAT=""
for ((I=1; I<=$WORKSPACE_COUNT; I++)); do
  WINDOW_STATUS_FORMAT+="#{?#{==:#W,"$WORKSPACE_NAME[$I]"},#[fg="$WORKSPACE_COLOR[$I]"],}"
  WINDOW_STATUS_CURRENT_FORMAT+="#{?#{==:#W,"$WORKSPACE_NAME[$I]"},#[bg="$WORKSPACE_COLOR[$I]"],}"
done
WINDOW_STATUS_FORMAT+="#[italics]#[bold]#W "
WINDOW_STATUS_CURRENT_FORMAT+="#[fg=#dddddd]#{?#{!=:#W,"$WORKSPACE_NAME[1]"},▏, }#[fg=#ffffff]#[italics]#[bold]#W "

# 同じレイアウトで複数のワークスペースを作成
for ((I=1; I<=$WORKSPACE_COUNT; I++)); do
  if [ $I = 1 ]; then
    # 1つ目のワークスペースはセッション作成と同時に作成
    tmux new-session -d -A -s "$SESSION_NAME" -c $WORKSPACE_PATH[$I] -x $COLUMNS -y $LINES 'nvim'
  else
    # 以降のワークスペースはウィンドウを作成
    tmux new-window -c $WORKSPACE_PATH[$I] 'nvim'
  fi
  tmux set -p remain-on-exit on
  # ウィンドウの名前を変更
  tmux rename-window "$WORKSPACE_NAME[$I]"
  # 縦 25% の位置で分割
  tmux split-window -v -p 25 -c "#{pane_current_path}"
  # 横 50% の位置で分割
  tmux split-window -h -p 50 -c "#{pane_current_path}"
  # メインのペインにフォーカスしてズーム
  tmux select-pane -t 0
  tmux resize-pane -Z

  # タブのフォーマットを指定
  tmux set-window-option window-status-format $WINDOW_STATUS_FORMAT
  tmux set-window-option window-status-current-format $WINDOW_STATUS_CURRENT_FORMAT
done

# 最初のウィンドウにフォーカスする
tmux select-window -t 0

# 現在のターミナルをセッションにアタッチする
tmux attach -t $SESSION_NAME
