{pkgs, ...}: {
  home.packages = with pkgs; [
    grimblast
    ripgrep
    unzip
    curl
    wget
    wl-clipboard
    iw
    zip

    brightnessctl
    playerctl
  ];
}
