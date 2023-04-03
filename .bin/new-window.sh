#!/bin/zsh

# 以降のワークスペースはウィンドウを作成
tmux new-window -c $1 -n $(basename $1) 'nvim +"Neotree focus"'

tmux set -p remain-on-exit on
# ウィンドウの名前を変更
# 縦 25% の位置で分割
tmux split-window -v -p 25 -c "#{pane_current_path}"
# 横 50% の位置で分割
tmux split-window -h -p 50 -c "#{pane_current_path}"
# メインのペインにフォーカスしてズーム
tmux select-pane -t 0
