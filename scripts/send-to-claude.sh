#!/bin/bash
# Claude ペインにテキストを送信する
# 引数があればその文字列を、なければ stdin を使う

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
  tmux send-keys -t "$CLAUDE_PANE" "$TEXT" Enter
else
  printf '%s' "$TEXT" | tmux load-buffer -
  tmux paste-buffer -p -t "$CLAUDE_PANE"
fi
tmux select-pane -t "$CLAUDE_PANE"
