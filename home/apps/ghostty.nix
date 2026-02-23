{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableFishIntegration = true;
  };
}

