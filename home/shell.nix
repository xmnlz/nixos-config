{ pkgs, ... }:

{
  home.packages = with pkgs; [
    vesktop
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
