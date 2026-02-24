{ inputs, ... }:

{
  imports = [
    ./home/shell.nix
    ./home/apps/vicinae.nix
    ./home/hypr
    ./home/development.nix
    ./home/gaming.nix
    ./home/apps/ghostty.nix
    ./home/apps/neovim
    ./home/apps/tmux
    ./home/apps/opencode.nix
    inputs.vicinae.homeManagerModules.default
  ];


  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
    stateVersion = "25.11";
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/nixos-config";
      nrb = "sudo nixos-rebuild boot --flake ~/nixos-config";
    };
  };
  
  # This is requred to just restart the hm modules included
  programs.home-manager.enable = true;
}
