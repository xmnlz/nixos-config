{pkgs, ...}: {
  imports = [../../home];

  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
    stateVersion = "26.05";

    pointerCursor = {
      enable = true;
      package = pkgs.apple-cursor;
      name = "macOS-White";
      size = 28;

      hyprcursor.enable = true;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
