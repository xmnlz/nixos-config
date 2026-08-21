{self, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    self.overlays.spotify-jam
    self.overlays.curl-cffi-skip-tests
  ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = ["nix-command" "flakes"];
  };

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
}
