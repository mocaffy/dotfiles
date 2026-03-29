{ config, ... }: {
  home.file.".mozilla/firefox/chrome/userChrome.css".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/programs/firefox/chrome/userChrome.css";
}
