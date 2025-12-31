{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    google-chrome
    telegram-desktop
    gh
  ];

  imports = [
    ../../modules/home/common.nix
  ];

}
