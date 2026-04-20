{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify
  ];

  programs.obs-studio = {
    enable = true;
  };
}
