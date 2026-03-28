#!/bin/zsh
yabai -m window --toggle topmost
local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
if [ -n "$selected_dir" ]; then
  ~/dotfiles/.bin/new-window.sh $selected_dir
  zle accept-line
fi
zle clear-screen
