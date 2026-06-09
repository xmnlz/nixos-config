{pkgs, ...}: {
  home.packages = with pkgs; [
    spotify
    blender
  ];

  programs.obs-studio = {
    enable = true;
  };

  programs.mpv.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "video/mp4" = ["mpv.desktop"];
      "video/x-matroska" = ["mpv.desktop"];
      "video/webm" = ["mpv.desktop"];
      "video/avi" = ["mpv.desktop"];
      "video/quicktime" = ["mpv.desktop"];
      "video/x-msvideo" = ["mpv.desktop"];
      "video/mpeg" = ["mpv.desktop"];
      "video/ogg" = ["mpv.desktop"];
      "video/3gpp" = ["mpv.desktop"];
      "application/x-mpegURL" = ["mpv.desktop"];
    };
  };
}
