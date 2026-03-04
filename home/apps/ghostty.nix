{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableFishIntegration = true;
    settings = {
      window-padding-x = 0;
      window-padding-y = 0
    };
  };
}

