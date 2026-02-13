{ config, pkgs, ... }:

{
  # ============================================================================
  # Common NixOS Configuration
  # ============================================================================
  # This module contains system-wide settings shared across all NixOS hosts
  # It should only contain truly common settings that apply everywhere
  # Host-specific settings belong in hosts/<hostname>/modules/system.nix
  # ============================================================================

  # ----------------------------------------------------------------------------
  # Nix Package Manager Configuration
  # ----------------------------------------------------------------------------
  nix.settings = {
    # experimental-features: Enable modern Nix features
    # - nix-command: New unified 'nix' command interface
    #   Example: 'nix run', 'nix shell', 'nix build' instead of nix-env/nix-build
    # - flakes: Reproducible package management with lock files
    #   Enables flake.nix for deterministic, cacheable builds
    # Reference: https://nixos.wiki/wiki/Flakes
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  # nixpkgs.config: Nixpkgs repository configuration
  # allowUnfree: Permit installation of proprietary/closed-source software
  # Required for: Steam, Discord, VS Code, Spotify, Chrome, NVIDIA drivers, etc.
  # Security consideration: Unfree software may have privacy/security implications
  # Reference: https://nixos.wiki/wiki/FAQ#How_can_I_install_a_proprietary_or_unfree_package.3F
  nixpkgs.config.allowUnfree = true;

  # ----------------------------------------------------------------------------
  # Automatic Garbage Collection
  # ----------------------------------------------------------------------------
  # Nix stores every package version and build, which can consume disk space
  # Garbage collection removes old, unused packages and system generations
  # Reference: https://nixos.org/manual/nix/stable/package-management/garbage-collection.html
  nix.gc = {
    # automatic: Enable automatic garbage collection
    automatic = true;
    
    # dates: When to run garbage collection (systemd timer format)
    # "daily" runs once per day at midnight
    # Other options: "weekly", "monthly", "03:15" (specific time)
    # Check with: systemctl status nix-gc.timer
    dates = "daily";
    
    # options: Arguments passed to 'nix-collect-garbage'
    # --delete-older-than: Remove generations older than specified time
    # "3d" = 3 days, "7d" = 1 week, "30d" = 1 month
    # Note: Typo in original ("then" should be "than") - fixed below
    # WARNING: Shorter retention means less ability to rollback!
    options = "--delete-older-than 3d";
  };

  # ----------------------------------------------------------------------------
  # Timezone Configuration
  # ----------------------------------------------------------------------------
  # System timezone for correct local time display
  # This affects system logs, file timestamps, and date/time in applications
  # Find your timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Europe/Berlin";

  # ----------------------------------------------------------------------------
  # Localization (i18n)
  # ----------------------------------------------------------------------------
  # i18n: Internationalization settings for language and regional formats
  # Reference: https://nixos.wiki/wiki/Locales
  i18n = {
    # defaultLocale: Primary system language for UI and messages
    # en_US.UTF-8: American English with UTF-8 encoding (universal standard)
    # Other options: en_GB.UTF-8 (British), de_DE.UTF-8 (German), etc.
    defaultLocale = "en_US.UTF-8";
    
    # extraLocaleSettings: Override specific locale categories
    # Useful for: English UI but European date/number formats
    # Categories:
    # - LC_TIME: Date/time format (24h vs 12h, DD/MM vs MM/DD)
    # - LC_MONETARY: Currency symbol and format (€1.234,56 vs $1,234.56)
    # - LC_NUMERIC: Number format (1,5 vs 1.5 for decimals)
    # - LC_MEASUREMENT: Metric vs Imperial units
    # - LC_PAPER: Default paper size (A4 vs Letter)
    # - LC_TELEPHONE: Phone number format
    # - LC_ADDRESS: Address format conventions
    # - LC_NAME: Name format (Given Surname vs Surname, Given)
    # - LC_IDENTIFICATION: System identification strings
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";        # German address format
      LC_IDENTIFICATION = "de_DE.UTF-8";  # German system identification
      LC_MEASUREMENT = "de_DE.UTF-8";     # Metric system
      LC_MONETARY = "de_DE.UTF-8";        # Euro currency format
      LC_NAME = "de_DE.UTF-8";            # German name format
      LC_NUMERIC = "de_DE.UTF-8";         # Comma as decimal separator
      LC_PAPER = "de_DE.UTF-8";           # A4 paper size
      LC_TELEPHONE = "de_DE.UTF-8";       # German phone format
      LC_TIME = "de_DE.UTF-8";            # 24-hour clock, DD.MM.YYYY
    };
  };
}
