{ inputs, pkgs, ... }:

{
  gtk = {
    enable = true;
    colorScheme = "dark";
  };

  qt = {
    enable = true;
  };

  home.packages = with pkgs; [
    # apps 
    telegram-desktop
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    google-chrome
    obs-studio
    vesktop
    spotify
    steam

    # shell
    alacritty
    tmux
    git
    gh

    # utils
    inputs.hyprland-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
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
