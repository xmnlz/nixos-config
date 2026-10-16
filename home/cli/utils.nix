{pkgs, ...}: {
  home.packages = with pkgs; [
    grimblast
    agent-browser
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
