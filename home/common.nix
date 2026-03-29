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
      ws = "~/dotfiles/scripts/tmux-layout-setup.sh";
    };
    autosuggestion.enable = true;
    initContent = ''
      set -o ignoreeof
      export PATH="$HOME/.local/bin:$PATH"
      [[ -n "$HISTFILE_OVERRIDE" ]] && HISTFILE="$HISTFILE_OVERRIDE"

      # fzf の Ctrl+R で ~/.workspace/history/ 配下の全履歴をマージして検索
      fzf-history-widget() {
        local selected
        setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null
        selected=$(
          { cat ~/.zsh_history ~/.workspace/history/* "$HISTFILE" 2>/dev/null; } \
            | awk '!seen[$0]++' \
            | fzf --tac --no-sort --query "$LBUFFER" --scheme=history
        )
        if [[ -n "$selected" ]]; then
          LBUFFER=$selected
        fi
        zle reset-prompt
      }
      zle -N fzf-history-widget
      bindkey '^R' fzf-history-widget
    '';
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
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
