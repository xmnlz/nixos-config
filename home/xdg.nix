{config, ...}: {
  xdg.userDirs = {
    enable = true;

    download = "${config.home.homeDirectory}/downloads";
    documents = "${config.home.homeDirectory}/documents";
    projects = "${config.home.homeDirectory}/projects";
  };
}
