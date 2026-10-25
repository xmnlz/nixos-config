{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;

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
