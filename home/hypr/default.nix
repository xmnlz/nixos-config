{ pkgs, ... }:

{
  wayland.windowManager.hyprland.systemd = {
    variables = [ "--all" ];
  };

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
}
