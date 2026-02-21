{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages;

  boot.loader = {
    limine = {
      enable = true;
      maxGenerations = 4;
    };

    efi.canTouchEfiVariables = true;
  };
}
