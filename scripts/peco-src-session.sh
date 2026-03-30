#!/bin/zsh

source "$(dirname $0)/tmux-window-layout-lib.sh"

local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
if [ -z "$selected_dir" ]; then
  return 0
fi

local session_name=$(basename "$selected_dir")

# メインの worktree (選択したリポジトリ自体) と追加の worktree を取得
local worktree_paths=()
while IFS= read -r line; do
  worktree_paths+=("$line")
done < <(git -C "$selected_dir" worktree list --porcelain 2>/dev/null | grep '^worktree ' | sed 's/^worktree //')

# worktree がなければリポジトリ自体のみ
if [ ${#worktree_paths[@]} -eq 0 ]; then
  worktree_paths=("$selected_dir")
fi

for ((i=1; i<=${#worktree_paths[@]}; i++)); do
  local wt_path="${worktree_paths[$i]}"
  local wt_name=$(basename "$wt_path")

  if [ $i -eq 1 ]; then
    tmux new-session -d -s "$session_name" -c "$wt_path" -x "$(tmux display -p '#{window_width}')" -y "$(tmux display -p '#{window_height}')" 'nvim +"Neotree focus"'
  else
    tmux new-window -t "$session_name" -c "$wt_path" 'nvim +"Neotree focus"'
  fi
  tmux rename-window -t "$session_name" "$wt_name"
  sleep 0.1
  setup_window_panes "$wt_path" "$session_name:$wt_name"
done

tmux switch-client -t "$session_name"
