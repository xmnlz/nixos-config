{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelParams = [
    "amdgpu.dc=1"
    "amdgpu.runpm=0"
    "amdgpu.aspm=0"
    "amdgpu.dpm=1"
    "video=efifb:off"
    "ucsi_acpi.disable_usb_errors=1"
  ];

  boot.loader = {
    limine = {
      enable = true;
      maxGenerations = 4;
    };

    efi.canTouchEfiVariables = true;
  };
}
