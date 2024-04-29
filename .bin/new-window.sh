#!/bin/zsh

# 以降のワークスペースはウィンドウを作成
tmux new-window -c $1 -n $(basename $1) 'nvim +"Neotree focus"'

tmux set -p remain-on-exit on
# ウィンドウの名前を変更
# 縦 25% の位置で分割
tmux split-window -v -l 16 -c "#{pane_current_path}" "NVIM_APPNAME=nvim-term nvim -u ~/.config/nvim-term/init.lua -c 'ter HISTFILE=~/.workspace/history/$I-3 zsh' -c 'vs' -c 'ter HISTFILE=~/.workspace/history/$I-2 zsh' -c 'vs' -c 'ter HISTFILE=~/.workspace/history/$I-1 zsh'"
tmux set -p remain-on-exit on
# メインのペインにフォーカスしてズーム
tmux select-pane -t 0
