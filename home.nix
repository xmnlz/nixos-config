{ pkgs, ... }:

{
  imports = [ ./home ];

  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
    stateVersion = "26.05";

    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      LIBVA_DISPLAY = "drm";
    };

    pointerCursor = {
      enable = true;
      package = pkgs.kuromi-cursor;
      name = "Kuromi-cursor";
      size = 48;

      hyprcursor.enable = true;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
