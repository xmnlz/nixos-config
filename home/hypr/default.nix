{ pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    package = pkgs.hyprpaper;
    settings = {
      splash = false;

      wallpaper = [
        {
          monitor = "";
          path = "~/wallpapers";
          # 12 hours
          timeout = 43200;
        }
      ];
    };
  };

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
