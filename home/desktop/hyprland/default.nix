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
          # 30min
          timeout = 1800;
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
