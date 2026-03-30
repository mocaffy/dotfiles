#!/bin/zsh

# 対象ウィンドウ ID を記録（後で別ウィンドウに切り替わっても正しく閉じるため）
local target_window=$(tmux display -p '#{window_id}')

git wt -D .

if [ $? -eq 0 ]; then
  echo "Worktree deleted. Closing window..."
  sleep 1
  tmux kill-window -t "$target_window"
else
  echo "Failed to delete worktree."
  read "?Press Enter to close..."
fi
