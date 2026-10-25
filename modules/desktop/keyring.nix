{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;

  # Stopgap: the daemon aborts when apps open sessions at once (GNOME/gnome-keyring#195), until MR !112 is released and reaches nixpkgs-unstable
  nixpkgs.overlays = [
    (final: prev: {
      gnome-keyring = prev.gnome-keyring.overrideAttrs (old: {
        patches =
          (old.patches or [])
          ++ map ({rev, hash}:
            final.fetchpatch {
              url = "https://gitlab.gnome.org/GNOME/gnome-keyring/-/commit/${rev}.patch";
              inherit hash;
            }) [
            {
              rev = "c06dd839a40517c5c0470fd492d2b07ce1356d2e";
              hash = "sha256-xrp+59KiD/dp2lt45IFYZMBHw41U949ZNJ3gpLcm1NI=";
            }
            {
              rev = "8fcdeffe67ae8c1600eae9637816acbf73f66b81";
              hash = "sha256-E4peyaX/Z91YE7JGOMwfMyidKdf3Xb4uU5bk3MFXU1A=";
            }
          ];
      });
      # Only its tests use gnome-keyring, so keep it on the cached build.
      bitwarden-desktop = prev.bitwarden-desktop.override {inherit (prev) gnome-keyring;};
    })
  ];

  environment.systemPackages = with pkgs; [
    libsecret
    seahorse
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;
  # greetd stacks on login. A fingerprint login gives PAM no password, so the keyring would stay locked.
  security.pam.services.login.fprintAuth = false;
  security.pam.services.dankshell = {
    enableGnomeKeyring = true;
    fprintAuth = false;
  };
}
