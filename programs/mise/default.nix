{ config, ... }: {
  xdg.configFile."mise/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/mise/config.toml";
}
