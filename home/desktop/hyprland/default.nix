{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "";
          path = "~/wallpapers";
          # 4 hours
          timeout = 14400;
        }
      ];
    };
  };

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/xdph.conf".text = ''
    screencopy {
      allow_token_by_default = true
    }
  '';
}
