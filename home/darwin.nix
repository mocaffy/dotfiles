{ pkgs, ... }:
{
  # macOS 固有の設定

  home.sessionPath = [
    "/opt/homebrew/bin"
  ];

  xdg.configFile = {
    "alacritty-local.toml".source = ../programs/alacritty/mac.toml;
  };
}
