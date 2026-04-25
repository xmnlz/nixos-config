{ self, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [ self.overlays.kuromi-cursor ];

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };
}
