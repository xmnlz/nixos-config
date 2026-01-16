{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
  };

  home.packages = with pkgs; [
    zsh
    git
    btop
    neovim
    fastfetch
    tmux
    ripgrep
    curl
    wget
    unzip
    zip
  ];
}
