#!/bin/bash
# コピーモードで選択したテキストを Claude ペインに送信する

TEXT=$(cat)

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

printf '%s' "$TEXT" | tmux load-buffer -
tmux paste-buffer -p -t "$CLAUDE_PANE"
tmux select-pane -t "$CLAUDE_PANE"
