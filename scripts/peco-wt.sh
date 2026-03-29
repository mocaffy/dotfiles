#!/bin/zsh

function _peco_wt() {
  # 現在のリポジトリで git が初期化されているか確認
  if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not a git repository"
    return 1
  fi

  # worktree のベースディレクトリを設定（プロジェクト内直下の .worktrees）
  if ! git config wt.basedir > /dev/null 2>&1; then
    git config wt.basedir ".worktrees"
    echo "Set wt.basedir to '.worktrees'"
  fi

  # 既存の worktree を取得
  local existing_worktrees=$(git worktree list --porcelain 2>/dev/null | \
    grep '^worktree ' | \
    sed 's/^worktree //')

  # リモートブランチを取得（origin/ を除く）
  local remote_branches=$(git branch -r --format='%(refname:short)' 2>/dev/null | \
    grep '^origin/' | \
    sed 's/^origin\///' | \
    grep -v 'HEAD' | \
    sort -u)

  # ローカルブランチを取得
  local local_branches=$(git branch --format='%(refname:short)' 2>/dev/null | sort -u)

  # すべてのブランチを結合して重複を排除
  local all_branches=$(echo -e "${remote_branches}\n${local_branches}" | sort -u)

  # 既存の worktree がある場合はそれを優先表示
  local worktree_list
  if [ -n "$existing_worktrees" ]; then
    worktree_list=$(echo "$existing_worktrees" | while read -r path; do
      local branch=$(git -C "$path" branch --show-current 2>/dev/null || echo "unknown")
      echo "[OPEN] $path ($branch)"
    done)
  else
    worktree_list="[OPEN] (no existing worktrees)"
  fi

  # peco で選択
  local selected=$(echo -e "${worktree_list}\n[NEW BRANCH]\n${all_branches}" | peco --query "$LBUFFER")

  if [ -z "$selected" ]; then
    return 0
  fi

  # 既存の worktree を開く場合
  if [[ "$selected" == "[OPEN]"* ]]; then
    local worktree_dir=$(echo "$selected" | sed 's/^\[OPEN] //' | sed 's/ (.*$//')
    if [ -d "$worktree_dir" ]; then
      ~/dotfiles/scripts/new-window.sh "$worktree_dir"
    fi
    return 0
  fi

  # 新規ブランチ作成の場合
  local branch
  if [ "$selected" = "[NEW BRANCH]" ]; then
    # ベースブランチを選択（現在のブランチをデフォルト）
    local current_branch=$(git branch --show-current)
    local base_branch=$(echo -e "${all_branches}" | peco --query "$current_branch" --prompt="Base branch: ")
    if [ -z "$base_branch" ]; then
      return 0
    fi

    # 新規ブランチ名を入力
    echo "Enter new branch name (based on $base_branch):"
    local new_branch
    read new_branch
    if [ -z "$new_branch" ]; then
      return 0
    fi

    # git-wt で新規ブランチから worktree を作成（現在のディレクトリは変更しない）
    branch="$new_branch"
    local output=$(git wt --nocd "$branch" "$base_branch" 2>&1)
  else
    branch="$selected"
    # 既存ブランチから worktree を作成
    local output=$(git wt --nocd "$branch" 2>&1)
  fi

  local wt_status=$?

  if [ $wt_status -ne 0 ]; then
    # 既存の worktree がある場合はそのパスを取得
    if echo "$output" | grep -q "already exists"; then
      local worktree_dir=$(git worktree list --porcelain 2>/dev/null | \
        grep "branch refs/heads/$branch" -B1 | \
        grep '^worktree ' | \
        sed 's/^worktree //')
    else
      echo "Error: Failed to create worktree"
      echo "$output"
      return 1
    fi
  else
    # worktree パスを抽出（git-wt の出力から）
    local worktree_dir=$(echo "$output" | tail -1)
  fi

  # パスが存在するか確認
  if [ ! -d "$worktree_dir" ]; then
    echo "Error: Worktree directory not found: $worktree_dir"
    return 1
  fi

  # new-window.sh を呼び出し
  ~/dotfiles/scripts/new-window.sh "$worktree_dir"
}

_peco_wt
