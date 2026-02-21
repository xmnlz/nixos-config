{ ... }:

{
  programs.niri= {
    enable = true;
  };

  programs.hyprland= {
    enable = true;
  };


  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
}
