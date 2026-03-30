{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
    "skhd/skhdrc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/skhd/skhdrc";
  };
}
