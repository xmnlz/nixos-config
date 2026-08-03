{...}: {
  programs.ssh = {
    enable = true;

    # Don't inherit home-manager's soon-to-be-removed defaults for "*"
    enableDefaultConfig = false;

    settings."*" = {
      AddKeysToAgent = "yes";

      # Drop a session that stops answering instead of hanging forever, which
      # is what a lossy wifi link would otherwise give us
      ServerAliveInterval = 15;
      ServerAliveCountMax = 4;

      # Reuse one connection for repeated ssh/scp/rsync/git to the same host.
      # %C is a short hash, so the socket path can't blow the 108-byte unix
      # socket limit the way master-%r@%n:%p does with long hostnames
      ControlMaster = "auto";
      ControlPath = "~/.ssh/sockets/%C";
      ControlPersist = "10m";

      # OpenSSH marks its packets DSCP EF, which access points map onto the WMM
      # Voice queue. Some of them (Windows Mobile Hotspot included) stall those
      # frames, so the TCP handshake completes and then the connection dies at
      # banner exchange while ping over the same link stays clean
      IPQoS = "none";
    };
  };

  # ssh refuses to create ControlPath directories itself
  home.file.".ssh/sockets/.keep".text = "";
}
