{ pkgs, ... }: 

{
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    gnome-keyring
    libsecret
    seahorse
  ];

  security.pam.services.hyprlock.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
}
