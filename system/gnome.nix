{ ... }:

{
  programs.niri= {
    enable = true;
  };

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
}
