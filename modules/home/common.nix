{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
  };

  home.packages = with pkgs; [
    zsh
    git
    btop
    fastfetch
    tmux
    ripgrep
    curl
    wget
    unzip
    zip
  ];
}
