{ ... }:
{
  # Enable GNOME Desktop with GDM (recommended display manager)
  # GNOME's Mutter compositor supports both Wayland and X11
  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
}
