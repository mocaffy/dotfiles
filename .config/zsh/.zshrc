set -o ignoreeof  # Same as setting IGNOREEOF=10

setopt append_history
setopt inc_append_history
setopt share_history

export XDG_CONFIG_HOME="$HOME/.config"

eval "$(/home/mocaffy/.local/bin/mise activate zsh)"

export STARSHIP_CONFIG=~/.config/starship/starship.toml
eval "$(starship init zsh)"

export SAVEHIST=1000

# [[ -f ~/.inshellisense/zsh/init.zsh ]] && source ~/.inshellisense/zsh/init.zsh
