{ pkgs, home-manager, zen-browser, ... }:

{
  system.stateVersion = "25.11";

  imports = [
    ./hardware.nix

    ../../modules/nixos/common.nix
    ../../modules/nixos/users.nix
    ../../modules/nixos/gnome.nix
  ];

  services.xserver.enable = false;

  home-manager.extraSpecialArgs = { inherit zen-browser; };

  home-manager.users.xmnlz = {
    imports = [
      ./home.nix
    ];
  };

}
