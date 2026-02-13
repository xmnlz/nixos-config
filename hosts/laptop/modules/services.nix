{ config, pkgs, ... }:

{
  # ============================================================================
  # System Services Configuration
  # ============================================================================
  # This module enables and configures system-level services and daemons
  # Services run in the background and provide functionality like authentication
  # ============================================================================

  # ----------------------------------------------------------------------------
  # Fingerprint Authentication (fprintd)
  # ----------------------------------------------------------------------------
  # fprintd: Daemon for fingerprint reader support on Linux
  # Allows using your fingerprint instead of password for authentication
  # Compatible with most laptop fingerprint readers
  # Reference: https://fprint.freedesktop.org/
  services.fprintd.enable = true;

  # ----------------------------------------------------------------------------
  # PAM Fingerprint Authentication (COMMENTED OUT)
  # ----------------------------------------------------------------------------
  # PAM (Pluggable Authentication Modules): Linux authentication framework
  # These settings would enable fingerprint authentication for various services
  # Currently disabled - uncomment to enable fingerprint login
  # 
  # WARNING: Test thoroughly before enabling! Misconfiguration can lock you out
  # Recommendation: Enable 'sudo' first, test it works, then enable 'login'
  #
  # Reference: https://nixos.wiki/wiki/Fprint
  # security.pam.services = {
  #   # login.fprintAuth: Enable fingerprint for console login (TTY)
  #   # Use case: Login to text console without password
  #   login.fprintAuth = true;
  #   
  #   # sudo.fprintAuth: Enable fingerprint for sudo commands
  #   # Use case: Run 'sudo <command>' and use fingerprint instead of password
  #   # WARNING: If fingerprint fails, you may be unable to use sudo!
  #   sudo.fprintAuth = true;
  #   
  #   # greetd.fprintAuth: Enable fingerprint for greetd display manager
  #   # Use case: Login to graphical session with fingerprint
  #   # Note: Requires greetd service to be enabled (see below)
  #   greetd.fprintAuth = true;
  # };

  # ----------------------------------------------------------------------------
  # Greetd Display Manager (COMMENTED OUT)
  # ----------------------------------------------------------------------------
  # Greetd: Minimal, flexible login manager for Wayland/X11
  # Alternative to GDM (GNOME), SDDM (KDE), or LightDM
  # Currently disabled because GNOME's GDM is likely being used instead
  #
  # If you want to use Greetd instead of GDM:
  # 1. Disable GDM in modules/nixos/gnome.nix
  # 2. Uncomment this configuration
  # 3. Configure the greeter UI (tuigreet, gtkgreet, or agreety)
  #
  # Reference: https://git.sr.ht/~kennylevinsen/greetd
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       # command: What to run after successful login
  #       # "Hyprland" launches Hyprland Wayland compositor
  #       # Other options: "sway", "gnome-session", "startplasma-wayland"
  #       command = "Hyprland";
  #       
  #       # user: Which user account to run the greeter as
  #       # "greeter" is a special unprivileged user for the login screen
  #       # DO NOT use your personal user account here!
  #       user = "greeter";
  #     };
  #   };
  # };
}
