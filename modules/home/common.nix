{ config, pkgs, ... }:

{
  home = {
    homeDirectory = "home/xmnlz";
  };

  home.packages = with pkgs; [
    git
    btop
    neovim
    tmux
    ripgrep
    curl
    wget
    unzip
    zip
  ];
}
