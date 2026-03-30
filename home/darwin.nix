{ pkgs, ... }:
{
  # macOS 固有の設定

  xdg.configFile = {
    "alacritty-local.toml".source = ../programs/alacritty/mac.toml;
  };
}
