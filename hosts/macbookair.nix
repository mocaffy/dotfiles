{ ... }: {
  imports = [
    ../home/common.nix
    ../home/linux.nix
  ];

  home.username = "mocaffy";
  home.homeDirectory = "/home/mocaffy";

  programs.git.settings = {
    user.name = "mocaffy";
    user.email = "mocaffy@gmail.com";
  };
}
