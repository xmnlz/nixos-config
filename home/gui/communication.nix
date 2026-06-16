{pkgs, ...}: {
  home.packages = with pkgs; [
    telegram-desktop
    discord
    vesktop
    slack
  ];
}
