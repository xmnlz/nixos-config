{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.xz";

    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

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

    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
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

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    overlays = {
      spotify-jam = final: prev: {
        spotify-jam = prev.callPackage ./pkgs/spotify-jam.nix {};
      };

      # curl-cffi 0.15.0 test suite fails against newer httpx, which breaks
      # yt-dlp and mpv. Mirrors NixOS/nixpkgs#554405; drop once the channel
      # ships curl-cffi 0.16.0.
      curl-cffi-skip-tests = final: prev: {
        pythonPackagesExtensions =
          prev.pythonPackagesExtensions
          ++ [
            (pyFinal: pyPrev: {
              curl-cffi = pyPrev.curl-cffi.overridePythonAttrs (old: {
                disabledTestPaths =
                  (old.disabledTestPaths or [])
                  ++ [
                    "tests/unittest/test_async_session.py::test_verify"
                    "tests/unittest/test_curl.py::test_verify"
                    "tests/unittest/test_requests.py::test_verify"
                    "tests/unittest/test_requests.py::test_delete_cookies"
                  ];
              });
            })
          ];
      };
    };

    mkHost = host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs self;};
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
