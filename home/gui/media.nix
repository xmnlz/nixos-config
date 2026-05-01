{ pkgs, ... }:

{
  home.packages = with pkgs; [
    spotify
    blender
  ];

  programs.obs-studio = {
    enable = true;
  };
}
