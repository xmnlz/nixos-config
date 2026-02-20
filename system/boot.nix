{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.loader = {
    limine = {
      enable = true;
      maxGenerations = 3;
    };

    efi.canTouchEfiVariables = true;
  };
}
