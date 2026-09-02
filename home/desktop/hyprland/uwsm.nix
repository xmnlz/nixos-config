{config, ...}: let
  cursor = config.home.pointerCursor;
in {
  # uwsm sources this file before starting the compositor and loads the
  # variables into the systemd user + dbus activation environment.
  home.file.".config/uwsm/env".text = ''
    export NIXOS_OZONE_WL=1
    export LIBVA_DRIVER_NAME=radeonsi
    export LIBVA_DISPLAY=drm

    export ELECTRON_OZONE_PLATFORM_HINT=auto
    export MOZ_ENABLE_WAYLAND=1

    # home.pointerCursor puts these in home.sessionVariables, but those only
    # reach interactive shells, never the compositor. Exporting them here is
    # what actually sets the cursor now that neither DMS nor an autostart
    # `hyprctl setcursor` does it
    export XCURSOR_THEME=${cursor.name}
    export XCURSOR_SIZE=${toString cursor.size}
    export HYPRCURSOR_THEME=${cursor.name}
    export HYPRCURSOR_SIZE=${toString cursor.size}
  '';
}
