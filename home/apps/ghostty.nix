{ config, pkgs, ... }:

{
  programs.ghostty = {
    enable = true;
    systemd.enable = true;
    enableFishIntegration = true;
    settings = {
      font-family = "JetBrainsMono Nerd Font Mono";
      font-size = 12;
      window-padding-x = 0;
      window-padding-y = 0;
    };
  };
}

