{ pkgs, lib, ... }: {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep
    ghq
    lazygit
    peco
    neovim
    tmux
  ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
    STARSHIP_CONFIG = lib.mkForce "$HOME/.config/starship/starship.toml";
  };

  programs.zsh = {
    enable = true;
    history = {
      size = 1000;
      append = true;
      share = true;
    };
    initContent = ''
      set -o ignoreeof
    '';
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
}
