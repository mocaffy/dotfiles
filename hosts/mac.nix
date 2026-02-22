{ ... }: {
  imports = [
    ../home/common.nix
    ../home/darwin.nix
  ];

  home.username = "mocaffy";
  home.homeDirectory = "/Users/mocaffy";
}
