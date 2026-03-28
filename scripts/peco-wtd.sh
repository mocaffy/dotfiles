#!/bin/zsh

function _peco_wtd() {
  # 現在のリポジトリで git が初期化されているか確認
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    return 1
  fi

  # 既存の worktree を取得
  local existing_worktrees=$(git worktree list --porcelain 2>/dev/null | \
    grep '^worktree ' | \
    sed 's/^worktree //')

  if [ -z "$existing_worktrees" ]; then
    echo "No existing worktrees"
    return 0
  fi

  # 現在のブランチを取得
  local current_branch=$(git branch --show-current)

  # worktree 一覧を表示
  local worktree_list=$(echo "$existing_worktrees" | while read -r path; do
    local branch=$(git -C "$path" branch --show-current 2>/dev/null || echo "unknown")
    if [ "$branch" = "$current_branch" ]; then
      echo "[CURRENT] $path ($branch)"
    else
      echo "[DELETE] $path ($branch)"
    fi
  done)

  # peco で選択
  local selected=$(echo "$worktree_list" | peco --query "$LBUFFER")

  if [ -z "$selected" ]; then
    return 0
  fi

  # 現在の worktree は削除できない
  if [[ "$selected" == "[CURRENT]"* ]]; then
    echo "Error: Cannot delete current worktree"
    return 1
  fi

  # 削除する worktree のパスを抽出
  local worktree_dir=$(echo "$selected" | sed 's/^\[DELETE] //' | sed 's/ (.*$//')

  if [ ! -d "$worktree_dir" ]; then
    echo "Error: Worktree directory not found: $worktree_dir"
    return 1
  fi

  # 確認
  echo "Delete worktree: $worktree_dir"
  read "confirm?Are you sure? [y/N] "
  if [[ ! "$confirm" =~ ^[yY] ]]; then
    echo "Cancelled"
    return 0
  fi

  # git-wt で worktree を削除
  git wt -d "$worktree_dir"
  echo "Deleted worktree: $worktree_dir"
}

_peco_wtd
