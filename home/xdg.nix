{config, ...}: {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    desktop = "${config.home.homeDirectory}/desktop";
    documents = "${config.home.homeDirectory}/documents";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pictures";
    videos = "${config.home.homeDirectory}/videos";
    templates = "${config.home.homeDirectory}/templates";
    publicShare = "${config.home.homeDirectory}/share";
    projects = "${config.home.homeDirectory}/projects";
  };

  systemd.user.tmpfiles.rules = [
    "e %h/.cache - - - 30d"
    # Nix's tarball cache is a git repo, and losing old files from it breaks every fetch
    "x %h/.cache/nix"
    "e %h/.npm/_cacache - - - 30d"
    "e %h/.local/share/Trash/files - - - 30d"
    "e %h/.local/share/Trash/info - - - 30d"
  ];
}
