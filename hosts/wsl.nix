{ ... }: {
  imports = [
    ../home/common.nix
    ../home/linux.nix
  ];

  home.username = "mocaffy";
  home.homeDirectory = "/home/mocaffy";
}
