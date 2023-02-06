# dotfiles

AstroNvim + Tmux + Alacritty の編成など (WezTerm + LunarVim にするかも)

<!-- TOC -->

- [インストール](#インストール)
  - [NerdFont](#nerdfont)
  - [Starship](#starship)
  - [Alacritty](#alacritty)
  - [Tmux](#tmux)
  - [Neovim](#neovim)
  - [AstroNvim](#astronvim)
  - [Karabiner-Elements](#karabiner)
  - [yabai](#yabai)
  - [skhd](#skhd)
  - [delta](#delta)
- [セットアップ](#セットアップ)

<!-- /TOC -->

## インストール
### NerdFont
https://www.nerdfonts.com/
```
brew tap homebrew/cask-fonts
brew install --cask font-fira-code-nerd-font
brew install --cask font-victor-mono-nerd-font
```

### Starship
https://starship.rs/  
`brew install starship`

### Alacritty
https://alacritty.org/  
`brew install --cask alacritty`

### Tmux
https://github.com/tmux/tmux/wiki  
`brew install tmux`

### Neovim
https://neovim.io/  
`brew install neovim`

### AstroNvim
https://astronvim.github.io/  
Make a backup of your current nvim folder  
`mv ~/.config/nvim ~/.config/nvim.bak`  

Clean neovim folders (Optional but recommended)
```
mv ~/.local/share/nvim ~/.local/share/nvim.bak
mv ~/.local/state/nvim ~/.local/state/nvim.bak
mv ~/.cache/nvim ~/.cache/nvim.bak
```
Clone the repository  
`git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim`

## セットアップ
### クローン
`git clone https://github.com/mocaffy/dotfiles ~`

### バックアップとシンボリックリンク
(必要に応じて)  

```
mv ~/.config ~/.config.bak`
mv ~/.zshrc ~/.zshrc.bak  
mv ~/.zprofile ~/.zprofile.bak  
```

```
ln -fns ~/dotfiles/.config ~
ln -fns ~/.config/astro-nvim ~/.config/nvim/lua/user
```

```
ln -fns ~/.config/zsh/.zshrc ~
ln -fns ~/.config/zsh/.zprofile ~
```

### tmux-256color のインストール
https://gist.github.com/ssh352/785395faad3163b2e0de32649f7ed45c
```
curl -LO https://invisible-island.net/datafiles/current/terminfo.src.gz && gunzip terminfo.src.gz
/usr/bin/tic -xe tmux-256color terminfo.src
```

### Neovim プラグインのインストール  
`nvim +"PackerSync"`
