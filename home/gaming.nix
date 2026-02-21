{ ... }:

{
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    WAYLAND_DISPLAY = "wayland-0";
    SDL_VIDEODRIVER = "wayland";
    QT_QPA_PLATFORM = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
