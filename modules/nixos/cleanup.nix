{...}: {
  # systemd's own default is 10% of the filesystem, which on an 882G disk means
  # the journal is allowed to reach roughly 88G before anything stops it. It was
  # sitting at 1.1G with entries going back to the day the machine was installed
  services.journald.extraConfig = ''
    SystemMaxUse=500M
    SystemMaxFileSize=50M
    MaxRetentionSec=1month
  '';

  # Coredumps already expire on their own after two weeks via systemd's shipped
  # tmpfiles rule, but the size cap is another 10%-of-disk default. One node
  # crash had already parked a single 3.9G dump here
  systemd.coredump.settings.Coredump = {
    MaxUse = "2G";
    KeepFree = "10G";
  };
}
