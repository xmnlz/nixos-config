{...}: {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  xdg.portal = {
    enable = true;
    config.hyprland.default = ["hyprland" "gtk"];
  };
}
