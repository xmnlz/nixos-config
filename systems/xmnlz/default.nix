{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware.nix

    # Brings in the fingerprint reader (services.fprintd), the ectool firmware
    # bits and the amd_pstate tuning for this laptop
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series

    ../../modules/nixos/core.nix
    ../../modules/nixos/locale.nix
    ../../modules/nixos/cleanup.nix

    ../../modules/desktop/boot.nix
    ../../modules/desktop/general.nix
    ../../modules/desktop/greetd.nix
    ../../modules/desktop/hyprland.nix
    ../../modules/desktop/docker.nix
    ../../modules/desktop/keyring.nix
    ../../modules/desktop/bitwarden.nix
    ../../modules/desktop/nix-ld.nix
    ../../modules/desktop/files.nix
  ];

  system.stateVersion = "26.05";
  networking.hostName = "xmnlz";

  programs.fish.enable = true;

  users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = ["wheel" "networkmanager" "docker"];
    shell = pkgs.fish;
  };

  home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = {inherit inputs;};

    users = {
      xmnlz = import ./home.nix;
    };
  };
}
