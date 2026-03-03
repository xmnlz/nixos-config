{ inputs, pkgs, ... }:

{
  home.packages = with pkgs; [
    # apps 
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    telegram-desktop
    vesktop
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

    # test stuff
    inputs.hyprland-preview-share-picker.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
