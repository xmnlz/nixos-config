{
  config,
  pkgs,
  inputs,
  ...
}:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    inputs.zen-browser.packages.${pkgs.system}.default
    telegram-desktop
    gh
  ];

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/neovim
    ../../modules/home/ghostty
    ../../modules/home/vicinae.nix
  ];
}
