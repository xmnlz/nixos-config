{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
  };

  home.packages = with pkgs; [
    vencord
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
