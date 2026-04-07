{ inputs, pkgs, ... }:

{
  imports = [
    ./home/shell.nix

    ./home/hypr
    ./home/quickshell
    ./home/development.nix

    ./home/apps/neovim
    ./home/apps/tmux
    ./home/apps/ghostty.nix
    ./home/apps/alacritty.nix
    inputs.vicinae.homeManagerModules.default
    ./home/apps/vicinae.nix
    ./home/apps/opencode.nix
  ];


  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
    stateVersion = "26.05";
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config";
      nrb = "sudo nixos-rebuild boot --flake ~/nixos-config";
    };

    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      LIBVA_DISPLAY = "drm";
    };

    pointerCursor = {
      enable = true;
      package = pkgs.kuromi-cursor;
      name = "Kuromi-cursor";
      size = 48;

      hyprcursor.enable = true;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
