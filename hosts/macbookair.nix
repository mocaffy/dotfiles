{ ... }:
{
  imports = [
    ../home/common.nix
    ../home/linux.nix
  ];

  home.username = "mocaffy";
  home.homeDirectory = "/home/mocaffy";

  xdg.configFile."autostart/alacritty.desktop".text = ''
    [Desktop Entry]
    Type=Application
    Name=Alacritty
    Exec=/usr/bin/alacritty -e /bin/zsh -c "source /etc/profile.d/nix.sh; /home/mocaffy/dotfiles/scripts/tmux-layout-setup.sh || read -r"
    Hidden=false
    NoDisplay=false
    X-GNOME-Autostart-enabled=true
  '';

  programs.git.settings = {
    user.name = "mocaffy";
    user.email = "mocaffy@gmail.com";
  };
}
