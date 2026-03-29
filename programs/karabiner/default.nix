{ config, pkgs, lib, ... }: {
  xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
    "karabiner/karabiner.json".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/karabiner/karabiner.json";
    "karabiner/assets".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/karabiner/assets";
  };
}
