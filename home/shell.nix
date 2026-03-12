{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # apps 
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.hyprland-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
    telegram-desktop

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
    adwaita-qt
  ];
}
