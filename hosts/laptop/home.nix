{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    home-manager
    inputs.zen-browser.packages.${pkgs.system}.default
    telegram-desktop
    gh
  ];

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/languages.nix
    ../../modules/home/lsp.nix
    ../../modules/home/opencode.nix
    ../../modules/home/steam.nix
    ../../modules/home/neovim
    ../../modules/home/tmux
    ../../modules/home/ghostty
    ../../modules/home/vicinae.nix
  ];
}
