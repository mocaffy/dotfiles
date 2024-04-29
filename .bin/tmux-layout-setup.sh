#!/bin/zsh

# セッションの名前
SESSION_NAME=config

# ワークスペースの数
WORKSPACE_COUNT=2

# ワークスペース(タブ)の名前
WORKSPACE_NAME=(
  home
  dotfiles
)

# ワークスペースのパス
WORKSPACE_PATH=(
  ~/
  ~/dotfiles/
)

alias tmux='tmux -u'

# 同じレイアウトで複数のワークスペースを作成
for ((I=1; I<=$WORKSPACE_COUNT; I++)); do
  if [ $I = 1 ]; then
    # 1つ目のワークスペースはセッション作成と同時に作成
    tmux new-session -d -A -s "$SESSION_NAME" -c $WORKSPACE_PATH[$I] -x $COLUMNS -y $LINES 'nvim +"Neotree focus"'
  else
    # 以降のワークスペースはウィンドウを作成
    tmux new-window -c $WORKSPACE_PATH[$I] 'nvim +"Neotree focus"'
  fi
  tmux set -p remain-on-exit on
  # ウィンドウの名前を変更
  tmux rename-window "$WORKSPACE_NAME[$I]"
  # 縦 25% の位置で分割
  tmux split-window -v -l 16 -c "#{pane_current_path}" "NVIM_APPNAME=nvim-term nvim -u ~/.config/nvim-term/init.lua -c 'ter HISTFILE=~/.workspace/history/$I-3 zsh' -c 'vs' -c 'ter HISTFILE=~/.workspace/history/$I-2 zsh' -c 'vs' -c 'ter HISTFILE=~/.workspace/history/$I-1 zsh'"
  tmux set -p remain-on-exit on
  # メインのペインにフォーカスしてズーム
  tmux select-pane -t 0
  # tmux resize-pane -Z
done

# 最初のウィンドウにフォーカスする
# tmux select-window -t 0

# 現在のターミナルをセッションにアタッチする
tmux attach -t $SESSION_NAME
