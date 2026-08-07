{pkgs, ...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
    config.hyprland.default = ["hyprland" "gtk"];
  };
}
