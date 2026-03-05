{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  # FIXME: https://github.com/NixOS/nixpkgs/issues/484328
  programs.uwsm.waylandCompositors = {
    hyprland = {
      prettyName = "Hyprland";
      comment = "Hyprland compositor managed by UWSM";
      binPath = "/run/current-system/sw/bin/start-hyprland";
   };
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Clipboard
    # wl-clipboard
  ];
}
