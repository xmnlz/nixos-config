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
    # Temporary: the flake's glibc 2.42 can't load the system mesa (needs 2.43). Revert once fixed:
    # https://github.com/vicinaehq/vicinae/issues/2040
    package = pkgs.vicinae;

    systemd = {
      enable = true;
      autoStart = true;

      environment = {
        USE_LAYER_SHELL = 1;
      };
    };
  };
}
