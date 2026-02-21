{ inputs, pkgs, ... }:

{
  wayland.windowManager.hyprland.systemd = {
      variables = [ "--all" ];
  };

  services.vicinae = {
    enable = true;

    systemd = {
      enable = true;
      autoStart = true;
    };

    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      nix
      power-profile
    ];
  };

}
