{ pkgs, ... }:

{
  # wayland.windowManager.hyprland = {
  #   systemd = {
  #     enable = true;
  #     variables = [ "--all" ];
  #   };
  # };
  #

  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."niri/config.kdl".source = ./niri.kdl;
}
