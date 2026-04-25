{ inputs, pkgs, ... }:


{
   imports = [
    ./hardware.nix

    ../../modules/nixos/core.nix
    ../../modules/nixos/locale.nix

    ../../modules/desktop/boot.nix
    ../../modules/desktop/general.nix
    ../../modules/desktop/hyprland.nix
  ] ++ [ 
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
  ];

   # nixpkgs.hostPlatform = { system = "aarch64-linux"; };

   system.stateVersion = "26.05";
   networking.hostName = "xmnlz";

   users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

   home-manager = {
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";
    extraSpecialArgs = { inherit inputs; };

    users = {
      xmnlz = import ./home.nix;
    };
  };
}
