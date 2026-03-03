{ ... }:

{
  home.sessionVariables = {
    ELECTRON_ENABLE_WAYLAND = 1;
    NIXOS_OZONE_WL = 1;
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };
}
