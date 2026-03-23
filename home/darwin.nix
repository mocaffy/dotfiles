{ pkgs, ... }: {
  # macOS 固有の設定

  xdg.configFile = {
    "karabiner".source = ../.config/karabiner;
    "skhd".source = ../.config/skhd;
    "yabai".source = ../.config/yabai;
  };
}
