{pkgs, ...}: {
  # The app itself is a home-manager package, but biometric unlock asks polkit
  # to authorize com.bitwarden.Bitwarden.unlock and polkitd only scans
  # /etc/polkit-1/actions and /run/current-system/sw/share/polkit-1/actions.
  # Nothing under /etc/profiles/per-user is ever read, so the action has to be
  # linked in from here. Without it the biometrics toggle in Bitwarden settings
  # silently turns itself back off after the next vault lock
  environment.etc."polkit-1/actions/com.bitwarden.Bitwarden.policy".source = "${pkgs.bitwarden-desktop}/share/polkit-1/actions/com.bitwarden.Bitwarden.policy";
}
