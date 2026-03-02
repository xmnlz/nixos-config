{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # apps 
    inputs.zen-browser.packages.${pkgs.system}.default
    telegram-desktop
    vesktop
    legcord
    spotify

    # shell
    tmux
    zsh
    git
    gh

    # utils
    fastfetch
    ripgrep
    unzip
    btop
    curl
    wget
    zip

    # ui
    quickshell
  ];
}
