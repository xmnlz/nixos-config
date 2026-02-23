{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # discord
    vesktop

    # shell
    tmux
    zsh
    git

    # utils
    fastfetch
    ripgrep
    unzip
    btop
    curl
    wget
    zip
  ];
}
