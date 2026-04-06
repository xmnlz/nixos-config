{ inputs, pkgs, ... }:

{
  services.vicinae = {
    enable = true;

    package = pkgs.vicinae;

    systemd = {
      enable = true;
      autoStart = true;

      environment = {
        USE_LAYER_SHELL = 1;
      };
    };

    extensions = with inputs.vicinae-extensions.packages.${pkgs.stdenv.hostPlatform.system}; [
      power-profile
      nix
    ];
  };

}
