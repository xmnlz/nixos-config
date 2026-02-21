{ ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
  };

  xdg.configFile."hypr/hyprland.conf".source = ./home/hypr/hyprland.conf;
}

