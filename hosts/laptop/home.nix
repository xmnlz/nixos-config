{ config, pkgs, ... }:

{
  home.stateVersion = "25.11";

  home.username = "xmnlz";
  home.homeDirectory = "/home/xmnlz";

  xdg.configFile."hypr".source = ./hypr;

  wayland.windowManager.hyprland.enable = true;

  home.packages = with pkgs; [
    stable.git
    neovim
    google-chrome
    telegram-desktop
    gh
  ];

  programs.git = {
    enable = true;
  };

}
