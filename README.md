# dotfiles

Nix/home-manager + AstroNvim + Tmux の開発環境構成。

<!-- TOC -->

- [構成概要](#構成概要)
- [セットアップ](#セットアップ)
  - [前提条件](#前提条件)
  - [インストール](#インストール)
  - [初回セットアップ後](#初回セットアップ後)
- [ホスト設定](#ホスト設定)
- [主要コンポーネント](#主要コンポーネント)
  - [Neovim (AstroNvim)](#neovim-astronvim)
  - [Tmux](#tmux)
  - [シェル (Zsh)](#シェル-zsh)
  - [ツール管理](#ツール管理)
- [スクリプト](#スクリプト)
- [プラットフォーム別設定](#プラットフォーム別設定)

<!-- /TOC -->

## 構成概要

```
dotfiles/
├── flake.nix                # Nix Flake メインエントリポイント
├── home/
│   ├── common.nix           # 全プラットフォーム共通設定
│   ├── linux.nix            # Linux/WSL 固有設定
│   └── darwin.nix           # macOS 固有設定
├── hosts/
│   ├── wsl.nix              # WSL Ubuntu
│   ├── mac.nix              # Intel Mac
│   └── macbookair.nix       # Apple Silicon Mac
├── programs/
│   ├── default.nix          # 各プログラム module の集約
│   ├── nvim/                # Neovim 設定と module
│   ├── tmux/                # tmux 設定と module
│   ├── claude/              # Claude Code 設定と module
│   ├── alacritty/           # Alacritty 設定と platform 別差分
│   └── ...                  # その他プログラムごとの設定
├── scripts/
│   ├── tmux-layout-setup.sh         # ワークスペース tmux セッション作成
│   ├── tmux-window-layout-lib.sh    # tmux ペインレイアウトライブラリ
│   ├── new-window.sh                # tmux ウィンドウ作成
│   ├── peco-wt.sh                   # Git worktree 管理 (peco)
│   ├── peco-wtd.sh                  # Git worktree 削除 (peco)
│   ├── peco-src.sh                  # リポジトリ選択 (macOS)
│   └── setup-keyd.sh                # keyd 設定インストール (Linux)
```

各プログラムの設定ファイルと Home Manager module を `programs/<name>/` にまとめ、`home/*.nix` は有効化と OS 差分だけを担当する構成。

## セットアップ

### 前提条件

- [Nix](https://nixos.org/download/) がインストールされていること
- Nix flakes が有効になっていること (`~/.config/nix/nix.conf` に `experimental-features = nix-command flakes`)
- [home-manager](https://github.com/nix-community/home-manager) がインストールされていること

### インストール

```bash
git clone https://github.com/mocaffy/dotfiles ~/dotfiles
```

ホストに合わせて home-manager を適用する:

```bash
# WSL Ubuntu
home-manager switch --flake ~/dotfiles#mocaffy@wsl

# Intel Mac
home-manager switch --flake ~/dotfiles#mocaffy@mac

# Apple Silicon Mac
home-manager switch --flake ~/dotfiles#mocaffy@MacBookAir
```

以後は `hms` エイリアスで更新できる:

```bash
hms   # home-manager switch --flake ~/dotfiles
```

### 初回セットアップ後

**Linux: keyd のセットアップ**
```bash
~/dotfiles/scripts/setup-keyd.sh
```

**tmux プラグインのインストール**
tmux を起動後、`prefix + I` で TPM プラグインをインストール。

**ワークスペースセッションの作成**
```bash
~/dotfiles/scripts/tmux-layout-setup.sh
```

## ホスト設定

| ホスト | ファイル | プラットフォーム |
|--------|----------|-----------------|
| `mocaffy@wsl` | `hosts/wsl.nix` | WSL Ubuntu |
| `mocaffy@mac` | `hosts/mac.nix` | macOS |
| `mocaffy@MacBookAir` | `hosts/macbookair.nix` | MacBook Air (Ubuntu) |

## プラットフォーム別設定

### Linux / WSL

- **keyd**: CapsLock→Ctrl、Alt/Meta 入れ替え、Meta+hjkl で矢印キー
- **フォント**: Noto Sans CJK JP、Fira Code Nerd Font
- **GNOME**: Super+Shift+P でカラーピッカー

### macOS

- **Karabiner-Elements**: キーボードリマップ
- **yabai**: タイリングウィンドウマネージャ
- **skhd**: ウィンドウ操作ホットキー

### 共通

- **Alacritty**: ターミナルエミュレータ (透過・装飾なし・最大化起動)
- **Tridactyl**: Firefox のキーボード操作
- **vifm**: ターミナルファイルマネージャ
