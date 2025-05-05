#!/bin/zsh

# Create a new window for the workspace
create_new_window() {
  local dir_path=$1

  tmux new-window -c "$dir_path" -n $(basename "$dir_path") 'nvim +"Neotree focus"'
  tmux set -p remain-on-exit on

  # Split vertically at 25%
  tmux split-window -v -p 25 -c "#{pane_current_path}"

  # Split horizontally at 50%
  tmux split-window -h -p 50 -c "#{pane_current_path}"

  # Focus and zoom the main pane
  tmux select-pane -t 0
}

create_new_window "$1"
