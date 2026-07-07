{...}: {
  # uwsm sources this file before starting the compositor and loads the
  # variables into the systemd user + dbus activation environment.
  home.file.".config/uwsm/env".text = ''
    export NIXOS_OZONE_WL=1
    export LIBVA_DRIVER_NAME=radeonsi
    export LIBVA_DISPLAY=drm

    export ELECTRON_OZONE_PLATFORM_HINT=auto
    export MOZ_ENABLE_WAYLAND=1
  '';
}
