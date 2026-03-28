#!/bin/zsh

source "$(dirname $0)/tmux-window-layout-lib.sh"

tmux new-window -c $1 -n $(basename $1) 'nvim +"Neotree focus"'
setup_window_panes $1
