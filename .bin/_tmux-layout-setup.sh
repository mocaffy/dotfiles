#!/bin/zsh

# Session name
SESSION_NAME="config"

# Number of workspaces
WORKSPACE_COUNT=2

# Workspace (tab) names
WORKSPACE_NAMES=(
  home
  dotfiles
)

# Workspace paths
WORKSPACE_PATHS=(
  ~/
  ~/dotfiles/
)

create_workspace() {
  local index=$1
  local dir_path=$2
  local name=$3

  if [ $index -eq 1 ]; then
    # Create the first workspace with the session
    tmux new-session -d -A -s "$SESSION_NAME" -c "$dir_path" -x $COLUMNS -y $LINES 'nvim +"Neotree focus"'
  else
    # Create subsequent workspaces as windows
    tmux new-window -c "$dir_path" 'nvim +"Neotree focus"'
  fi

  tmux set -p remain-on-exit on
  # Rename the window
  tmux rename-window "$name"

  # Split vertically at 25%
  tmux split-window -v -p 25 -c "#{pane_current_path}"

  # Split horizontally at 50%
  tmux split-window -h -p 50 -c "#{pane_current_path}"

  # Focus and zoom the main pane
  tmux select-pane -t 0
  # tmux resize-pane -Z
}


# Create multiple workspaces with the same layout
for ((i=1; i<=$WORKSPACE_COUNT; i++)); do
  create_workspace $i "${WORKSPACE_PATHS[$i]}" "${WORKSPACE_NAMES[$i]}"
done

tmux attach -t $SESSION_NAME
