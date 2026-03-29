{ config, ... }: {
  xdg.configFile."vifm/vifmrc".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/vifm/vifmrc";
}
