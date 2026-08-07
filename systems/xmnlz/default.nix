{
  inputs,
  pkgs,
  ...
}: {
  imports =
    [
      ./hardware.nix

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
    ]
    ++ [
      inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
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
