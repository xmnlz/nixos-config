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
  };

  outputs =
    { self, nixpkgs, home-manager, zen-browser, ... }:
    {
      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          home-manager.nixosModules.home-manager
          ./hosts/laptop
        ];
        specialArgs = {
          inherit home-manager;
          inherit zen-browser;
        };
      };
    };
}
