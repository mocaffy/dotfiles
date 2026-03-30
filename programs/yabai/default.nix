{
  config,
  pkgs,
  lib,
  ...
}:
{
  xdg.configFile = lib.mkIf pkgs.stdenv.isDarwin {
    "yabai/yabairc".source =
      config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/yabai/yabairc";
  };
}
