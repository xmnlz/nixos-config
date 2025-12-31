{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
    };

    vicinae = {
      url = "github:vicinaehq/vicinae";
    };
  };

  outputs = { self, ... }@inputs:
    {
      nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          inputs.home-manager.nixosModules.home-manager
          ./hosts/laptop
        ];
        specialArgs = { inherit inputs; };
      };
    };
}
