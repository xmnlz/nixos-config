{pkgs, ...}: {
  home.packages = with pkgs; [
    bitwarden-desktop
    bitwarden-cli
  ];

  systemd.user.services.bitwarden-desktop = {
    Unit = {
      Description = "Bitwarden desktop";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target" "tray.target"];
      Requires = ["tray.target"];
    };

    Service = {
      ExecStart = "${pkgs.bitwarden-desktop}/bin/bitwarden";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
