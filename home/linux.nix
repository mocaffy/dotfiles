{ pkgs, lib, ... }: {
  # WSL / Linux 固有の設定

  home.packages = with pkgs; [
    mise
    nerd-fonts.fira-code
  ];

  fonts.fontconfig.enable = true;

  xdg.configFile."alacritty-local.toml".source = ../.config/alacritty/linux.toml;

  programs.zsh.initContent = ''
    eval "$(mise activate zsh)"
  '';

  home.activation.miseTrust = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.mise}/bin/mise trust --all
  '';

  home.activation.tpmInstall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    _cloneIfMissing() {
      local repo="$1" dest="$2"
      if [ ! -d "$dest" ]; then
        ${pkgs.git}/bin/git clone "https://github.com/$repo" "$dest"
      fi
    }
    _cloneIfMissing tmux-plugins/tpm              "$HOME/.local/share/tmux/plugins/tpm"
    _cloneIfMissing tmux-plugins/tmux-copycat     "$HOME/.local/share/tmux/plugins/tmux-copycat"
    _cloneIfMissing tmux-plugins/tmux-open        "$HOME/.local/share/tmux/plugins/tmux-open"
    _cloneIfMissing mocaffy/tmux-tabicon          "$HOME/.local/share/tmux/plugins/tmux-tabicon"
  '';
}
