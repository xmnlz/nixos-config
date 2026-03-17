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
    ./home/apps/steam.nix
    inputs.vicinae.homeManagerModules.default
    ./home/apps/vicinae.nix
    ./home/apps/opencode.nix
  ];


  home = {
    sessionVariables = {
      LIBVA_DRIVER_NAME = "radeonsi";
      LIBVA_DISPLAY = "drm";
    };

    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
    stateVersion = "25.11";
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config";
      nrb = "sudo nixos-rebuild boot --flake ~/nixos-config";
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
  
  # This is requred to just restart only the hm 
  programs.home-manager.enable = true;
}
