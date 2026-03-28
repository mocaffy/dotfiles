#!/bin/zsh

source "$(dirname $0)/tmux-window-layout-lib.sh"

# セッションの名前
SESSION_NAME=config

# ホストに応じたワークスペース定義
if [[ -n "$WSL_DISTRO_NAME" ]]; then
  WORKSPACE_NAME=(win wsl dotfiles)
  WORKSPACE_PATH=(/mnt/c/Users/mocaffy/ ~/ ~/dotfiles/)
elif [[ "$(uname -s)" = "Darwin" ]]; then
  WORKSPACE_NAME=(home dotfiles)
  WORKSPACE_PATH=(~/ ~/dotfiles/)
else
  WORKSPACE_NAME=(home dotfiles)
  WORKSPACE_PATH=(~/ ~/dotfiles/)
fi

WORKSPACE_COUNT=${#WORKSPACE_NAME}

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
  # ウィンドウの名前を変更
  tmux rename-window "$WORKSPACE_NAME[$I]"
  setup_window_panes $WORKSPACE_PATH[$I]
done

# 現在のターミナルをセッションにアタッチする
tmux attach -t $SESSION_NAME
