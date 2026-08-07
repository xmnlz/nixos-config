{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    libsecret
    seahorse
  ];

  # greetd is the only thing that sees the password, so it is the only place
  # that can hand it to gnome-keyring and unlock the login keyring. The DMS
  # lock screen authenticates against its own bundled pam config and never
  # touches the keyring
  security.pam.services.greetd.enableGnomeKeyring = true;
}
