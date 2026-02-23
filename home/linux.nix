{ ... }: {
  # WSL / Linux 固有の設定

  programs.zsh.initContent = ''
    eval "$($HOME/.local/bin/mise activate zsh)"
  '';
}
