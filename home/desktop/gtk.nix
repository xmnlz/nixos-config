{pkgs, ...}: {
  gtk = {
    enable = true;
    colorScheme = "dark";
    iconTheme = {
      name = "hicolor";
      package = pkgs.hicolor-icon-theme;
    };
  };
}
