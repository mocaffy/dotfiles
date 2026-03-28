#!/bin/zsh

setup_window_panes() {
  # pane 0: nvim（初期ペイン）
  tmux set -p remain-on-exit on

  # 右側を横分割（30%）してclaudeを起動
  tmux split-window -h -p 30 -c "#{pane_current_path}" "zsh -ic 'claude'"
  tmux set -p remain-on-exit on

  # 右側を縦分割してnodeを下に起動
  tmux split-window -v -p 25 -c "#{pane_current_path}" "node"
  tmux set -p remain-on-exit on

  # 左上のペインを縦分割して下にzsh x2 のエリアを確保
  tmux select-pane -t 0
  tmux split-window -v -p 25 -c "#{pane_current_path}" "zsh"
  tmux set -p remain-on-exit on

  # 左下を横分割してzshを2ペインに
  tmux split-window -h -p 50 -c "#{pane_current_path}" "zsh"
  tmux set -p remain-on-exit on

  # nvimにフォーカス
  tmux select-pane -t 0
}
