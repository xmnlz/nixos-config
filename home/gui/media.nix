{pkgs, ...}: {
  home.packages = with pkgs; [
    # TODO: https://github.com/NixOS/nixpkgs/pull/53561 wait until this will be merged inside unstable
    (symlinkJoin {
      name = "spotify";
      paths = [spotify];
      buildInputs = [makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/spotify \
          --unset DISPLAY \
          --add-flags "--enable-features=UseOzonePlatform --ozone-platform=wayland"
      '';
    })
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
