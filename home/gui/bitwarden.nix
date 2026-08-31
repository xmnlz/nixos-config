{pkgs, ...}: let
  bitwardenDesktop = pkgs.writeShellScript "bitwarden-desktop" ''
    for _ in $(${pkgs.coreutils}/bin/seq 1 300); do
      locked=$(${pkgs.systemd}/bin/busctl --user get-property \
        org.freedesktop.secrets \
        /org/freedesktop/secrets/collection/login \
        org.freedesktop.Secret.Collection Locked 2>/dev/null || true)

      if [ "$locked" = "b false" ]; then
        exec ${pkgs.bitwarden-desktop}/bin/bitwarden --autostart
      fi

      ${pkgs.coreutils}/bin/sleep 1
    done

    exit 1
  '';
in {
  home.packages = with pkgs; [
    bitwarden-desktop
    bitwarden-cli
  ];

  systemd.user.services.bitwarden-desktop = {
    Unit = {
      Description = "Bitwarden desktop";
      PartOf = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };

    Service = {
      ExecStart = "${bitwardenDesktop}";
      Restart = "on-failure";
      RestartSec = 5;
    };

    Install.WantedBy = ["graphical-session.target"];
  };
}
