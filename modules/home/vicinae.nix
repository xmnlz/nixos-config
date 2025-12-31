{
  config,
  pkgs,
  inputs,
  ...
}:

{
  services.vicinae = {
    enable = true;
    systemd.enable = true;
  };
}