{ inputs, pkgs, ... }:

{
  imports = [
    ./home/shell.nix
    ./home/development.nix
    ./home/hypr
    ./home/gaming.nix
    ./home/apps/ghostty
    ./home/apps/neovim
    ./home/apps/tmux
    ./home/apps/opencode.nix
    ./home/apps/vicinae.nix
    inputs.vicinae.homeManagerModules.default
  ];

  home = {
    username = "xmnlz";
    homeDirectory = "/home/xmnlz";
    stateVersion = "25.11";

    packages = with pkgs; [
      inputs.zen-browser.packages.${pkgs.system}.default
      telegram-desktop
      gh
    ];
  };

  programs.home-manager.enable = true;
}
