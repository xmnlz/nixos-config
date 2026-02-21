{
  config,
  pkgs,
  lib,
  modulesPath,
  ...
}:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  boot.kernelPackages = pkgs.linuxPackages;

  boot.kernelParams = [
    "amdgpu.dc=1"
    "amdgpu.runpm=0"
    "amdgpu.aspm=0"
    "amdgpu.dpm=1"
    "video=efifb:off"
    "ucsi_acpi.disable_usb_errors=1"
  ];

  boot.initrd.availableKernelModules = [
    "nvme"
    "xhci_pci"
    "thunderbolt"
    "usb_storage"
    "sd_mod"
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  boot.kernelModules = [ "kvm-amd" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/3a6ac9d7-ad8f-40d0-b9f8-f3a9620b0f8c";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/9994-6C54";
    fsType = "vfat";
    options = [
      "fmask=0077"
      "dmask=0077"
    ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/16c98314-a9db-40b3-9229-623958f877c4"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
