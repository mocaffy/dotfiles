{ pkgs, lib, ... }:
{
  imports = [ ../programs ];

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
    mise
    lefthook
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
      hms = "home-manager switch --impure --flake ~/dotfiles#mocaffy@$(if [ \"$(uname)\" = 'Darwin' ]; then echo mac; else echo wsl; fi)";
      ws = "~/dotfiles/scripts/tmux-layout-setup.sh";
    };
    autosuggestion.enable = true;
    initContent = ''
      eval "$(mise activate zsh)"
      unsetopt PROMPT_SP
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

  home.activation.lefthookInstall = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ -d "$HOME/dotfiles/.git" ]; then
      cd "$HOME/dotfiles" && PATH="${pkgs.git}/bin:$PATH" ${pkgs.lefthook}/bin/lefthook install
    fi
  '';

  home.activation.miseTrust = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    ${pkgs.mise}/bin/mise trust --all
  '';

  home.activation.miseInstall = lib.hm.dag.entryAfter [ "miseTrust" ] ''
    ${pkgs.mise}/bin/mise install
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

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.git = {
    enable = true;
    ignores = [
      "**/.claude/settings.local.json"
      ".husky"
    ];
    settings = {
      ghq.root = "~/development";
    };
    signing.format = "openpgp";
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      golang.disabled = true;
    };
  };
}
