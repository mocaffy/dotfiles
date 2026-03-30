{ pkgs, lib, ... }:
{
  # WSL / Linux 固有の設定

  home.packages = with pkgs; [
    nerd-fonts.fira-code
    noto-fonts-cjk-sans
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts.sansSerif = [
      "Noto Sans CJK JP"
      "sans-serif"
    ];
  };

  xdg.configFile."alacritty-local.toml".source = ../programs/alacritty/linux.toml;

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
      ];
    };
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Color Picker";
      command = "zenity --color-selection --show-palette";
      binding = "<Super><Shift>p";
    };
  };

}
