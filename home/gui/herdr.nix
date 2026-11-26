{pkgs, ...}: {
  home.packages = with pkgs; [
    herdr-desktop
  ];
}
