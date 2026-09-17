{...}: {
  services.accounts-daemon.enable = true;

  systemd.tmpfiles.rules = [
    "L+ /var/lib/AccountsService/icons/xmnlz - - - - /home/xmnlz/pictures/avatar.png"
  ];
}
