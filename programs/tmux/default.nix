{ config, ... }:
{
  xdg.configFile."tmux/tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/tmux/tmux.conf";
}
