{ config, ... }:
{
  home.file.".claude/settings.local.json" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/claude/settings.local.json";
    force = true;
  };
}
