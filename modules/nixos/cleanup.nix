{...}: {
  services.journald.extraConfig = ''
    SystemMaxUse=500M
    SystemMaxFileSize=50M
    MaxRetentionSec=1month
  '';

  systemd.coredump.settings.Coredump = {
    MaxUse = "2G";
    KeepFree = "10G";
  };
}
