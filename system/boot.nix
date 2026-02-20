{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    limine = {
      enable = true;
      maxGenerations = 2;
    };

    efi.canTouchEfiVariables = true;
  };
}
