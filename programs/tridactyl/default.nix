{ config, ... }: {
  xdg.configFile."tridactyl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/tridactyl";
}
