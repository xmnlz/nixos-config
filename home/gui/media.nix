{pkgs, ...}: {
  home.packages = with pkgs; [
    spotify
    spotify-jam
    loupe
  ];

  programs.obs-studio = {
    enable = true;
  };

  programs.mpv.enable = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = ["zen-beta.desktop"];
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

      "image/png" = ["org.gnome.Loupe.desktop"];
      "image/jpeg" = ["org.gnome.Loupe.desktop"];
      "image/gif" = ["org.gnome.Loupe.desktop"];
      "image/webp" = ["org.gnome.Loupe.desktop"];
      "image/avif" = ["org.gnome.Loupe.desktop"];
      "image/heic" = ["org.gnome.Loupe.desktop"];
      "image/tiff" = ["org.gnome.Loupe.desktop"];
      "image/bmp" = ["org.gnome.Loupe.desktop"];
      "image/svg+xml" = ["org.gnome.Loupe.desktop"];
      "image/vnd.microsoft.icon" = ["org.gnome.Loupe.desktop"];
    };
  };
}
