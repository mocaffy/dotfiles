{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.configFile = lib.mkIf pkgs.stdenv.isLinux {
    "keyd/default.conf".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/keyd/default.conf";
  };
}
