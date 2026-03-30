{ ... }:
let
  user = builtins.getEnv "USER";
in
{
  imports = [
    ../home/common.nix
    ../home/darwin.nix
  ];

  home.username = user;
  home.homeDirectory = "/Users/${user}";
}
