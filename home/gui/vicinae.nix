{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  programs.vicinae = {
    enable = true;
    package = inputs.vicinae.packages.${pkgs.stdenv.hostPlatform.system}.default;

    systemd = {
      enable = true;
      autoStart = true;

      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };
}
