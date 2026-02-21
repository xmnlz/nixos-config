{ inputs, pkgs, ... }:

{
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
