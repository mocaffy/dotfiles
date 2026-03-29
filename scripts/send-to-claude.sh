#!/bin/bash
# Claude ペインにテキストを送信する
# Usage: send-to-claude.sh [-e] [-f] [text]
#   -e: Enter を送信する（デフォルト: なし）
#   -f: 送信後に Claude ペインにフォーカスする
#   引数なし: stdin からテキストを読む（コピーモード用）

SEND_ENTER=false
FOCUS=false
while true; do
  case "$1" in
    -e) SEND_ENTER=true; shift ;;
    -f) FOCUS=true; shift ;;
    *) break ;;
  esac
done

if [ $# -gt 0 ]; then
  TEXT="$*"
else
  TEXT=$(cat)
fi

if [ -z "$TEXT" ]; then
  exit 0
fi

# 同じウィンドウ内の Claude ペインを探す
CURRENT_SESSION=$(tmux display-message -p '#{session_name}')
CURRENT_WINDOW=$(tmux display-message -p '#{window_index}')

CLAUDE_PANE=$(tmux list-panes -t "$CURRENT_SESSION:$CURRENT_WINDOW" \
  -F '#{session_name}:#{window_index}.#{pane_index} #{pane_current_command}' \
  | grep ' claude$' | head -1 | awk '{print $1}')

if [ -z "$CLAUDE_PANE" ]; then
  tmux display-message "Claude ペインが見つかりません"
  exit 1
fi

if [ $# -gt 0 ]; then
  if $SEND_ENTER; then
    tmux send-keys -t "$CLAUDE_PANE" "$TEXT" Enter
  else
    tmux send-keys -t "$CLAUDE_PANE" "$TEXT"
  fi
else
  printf '%s' "$TEXT" | tmux load-buffer -
  tmux paste-buffer -p -t "$CLAUDE_PANE"
  FOCUS=true
fi

if $FOCUS; then
  tmux select-pane -t "$CLAUDE_PANE"
fi
