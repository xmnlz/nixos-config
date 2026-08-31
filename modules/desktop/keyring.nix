{pkgs, ...}: {
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    libsecret
    seahorse
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.dankshell = {
    enableGnomeKeyring = true;
    fprintAuth = false;
  };
}
