{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dms = {
      url = "github:AvengeMedia/DankMaterialShell/stable";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";

    vicinae-extensions = {
      url = "github:vicinaehq/extensions";
      inputs.vicinae.follows = "vicinae";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
  let
    overlays = {
      kuromi-cursor = final: prev: {
        kuromi-cursor = prev.callPackage ./pkgs/kuromi-cursor.nix {};
      };
    };

    mkHost = host: nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs self; };
      modules = [
        home-manager.nixosModules.home-manager
        ./systems/${host}
      ];
    };
  in {
    inherit overlays;

    nixosConfigurations = {
      xmnlz = mkHost "xmnlz";
    };
  };
}
