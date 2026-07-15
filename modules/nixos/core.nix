{self, ...}: {
  nixpkgs.config.allowUnfree = true;
  # vesktop bundles electron 40.10.5 (EOL); remove once vesktop upstream bumps electron
  nixpkgs.config.permittedInsecurePackages = ["electron-40.10.5"];
  nixpkgs.overlays = [self.overlays.kuromi-cursor];

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
