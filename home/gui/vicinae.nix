{
  inputs,
  pkgs,
  ...
}: let
  # Apps must be spawned by Hyprland itself to get HL_INITIAL_WORKSPACE_TOKEN,
  # and under the Lua config `hyprctl dispatch exec <cmd>` no longer parses.
  hl-exec = pkgs.writeShellApplication {
    name = "hl-exec";
    text = ''
      cmd=""
      for arg in "$@"; do
        cmd+=" $(printf '%q' "$arg")"
      done
      exec hyprctl eval "hl.exec_cmd([==[$cmd]==])"
    '';
  };
in {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;

    settings.providers.applications.preferences.launchPrefix = "${hl-exec}/bin/hl-exec uwsm app --";

    systemd = {
      enable = true;
      autoStart = true;

      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };
}
