{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  home.file.".config/uwsm/env".text = ''
    export NIXOS_OZONE_WL=1
  '';

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    config.hyprland.default = ["hyprland" "gtk"];
  };

  # services.displayManager.gdm.enable = true;
}
