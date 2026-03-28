{ pkgs, ... }: {
  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    ripgrep
    ghq
    lazygit
    peco
    neovim
    tmux
    gh
    python3
  ];

  home.sessionVariables = {
    XDG_CONFIG_HOME = "$HOME/.config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  programs.home-manager.enable = true;

  programs.zsh = {
    enable = true;
    history = {
      size = 1000;
      append = true;
      share = true;
    };
    shellAliases = {
      hms = "home-manager switch --flake ~/dotfiles#mocaffy@$(hostname)";
    };
    initContent = ''
      set -o ignoreeof
      export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      ghq.root = "~/development";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  xdg.configFile = {
    "nvim".source = ../.config/nvim;
    "tmux".source = ../.config/tmux;
    "lazygit".source = ../.config/lazygit;
    "mise".source = ../.config/mise;
    "alacritty".source = ../.config/alacritty;
    "tridactyl".source = ../.config/tridactyl;
    "vifm".source = ../.config/vifm;
  };
}
