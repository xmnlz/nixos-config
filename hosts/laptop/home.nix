{
  config,
  pkgs,
  zen-browser,
  ...
}:

{
  home.stateVersion = "25.11";

  home.packages = with pkgs; [
    google-chrome
    telegram-desktop
    gh
    zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  imports = [
    ../../modules/home/common.nix
    ../../modules/home/ghostty
  ];

}
