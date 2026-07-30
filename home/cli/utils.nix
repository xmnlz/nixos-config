{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.hyprland-contrib.packages.${pkgs.stdenv.hostPlatform.system}.grimblast
    ripgrep
    unzip
    curl
    wget
    wl-clipboard
    iw
    zip
  ];
}
