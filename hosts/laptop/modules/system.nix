{ config, pkgs, ... }:

{
  # ============================================================================
  # System Configuration - Host-Specific Settings
  # ============================================================================
  # This module contains system-level configurations specific to this laptop
  # including bootloader, kernel, networking, and hardware acceleration.
  #
  # Note: Gaming-related configurations have been moved to:
  #       ../../modules/nixos/gaming.nix
  # ============================================================================

  # ----------------------------------------------------------------------------
  # Boot Configuration
  # ----------------------------------------------------------------------------
  # Limine: A modern UEFI bootloader (alternative to GRUB/systemd-boot)
  # Advantages: Fast boot times, simple configuration, modern design
  # Reference: https://github.com/limine-bootloader/limine
  boot.loader = {
    limine = {
      enable = true;
      
      # maxGenerations: Number of NixOS generations to keep in boot menu
      # Older generations are garbage collected to save disk space
      # Set to 2 to keep only current + previous generation
      maxGenerations = 2;
    };
    
    efi = {
      # canTouchEfiVariables: Allows NixOS to modify UEFI boot entries
      # Required for Limine to properly install itself as the default boot option
      # Set to false if you get EFI variable write errors
      canTouchEfiVariables = true;
    };
  };

  # kernelPackages: Which Linux kernel version to use
  # linuxPackages_latest: Latest stable kernel (currently 6.x series)
  # Other options: linuxPackages (default LTS), linuxPackages_zen (gaming optimized)
  # Reference: https://nixos.wiki/wiki/Linux_kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # ----------------------------------------------------------------------------
  # Nix Package Manager Configuration
  # ----------------------------------------------------------------------------
  nix.settings = {
    # experimental-features: Enable modern Nix features
    # - nix-command: New unified 'nix' command (replaces nix-build, nix-env, etc.)
    # - flakes: Reproducible package management with flake.nix
    # Reference: https://nixos.wiki/wiki/Flakes
    experimental-features = [ "nix-command" "flakes" ];
  };

  # allowUnfree: Permit installation of proprietary software
  # Required for: Steam, NVIDIA drivers, Discord, VS Code, etc.
  # Reference: https://nixos.wiki/wiki/FAQ#How_can_I_install_a_proprietary_or_unfree_package.3F
  nixpkgs.config.allowUnfree = true;

  # ----------------------------------------------------------------------------
  # Networking Configuration
  # ----------------------------------------------------------------------------
  networking = {
    # hostName: Unique identifier for this machine on the network
    # Used by various services and network protocols
    hostName = "xmnlz-laptop";
    
    # NetworkManager: Modern network management daemon
    # Provides: WiFi, Ethernet, VPN management with GUI (nm-applet)
    # Alternative: systemd-networkd (simpler but less user-friendly)
    # Reference: https://nixos.wiki/wiki/NetworkManager
    networkmanager.enable = true;
  };

  # ----------------------------------------------------------------------------
  # Localization Configuration
  # ----------------------------------------------------------------------------
  # timeZone: System timezone for correct local time
  # Find your timezone: https://en.wikipedia.org/wiki/List_of_tz_database_time_zones
  time.timeZone = "Europe/Berlin";

  # i18n: Internationalization settings
  # defaultLocale: Primary language for system messages (en_US = English)
  # Reference: https://nixos.wiki/wiki/Locales
  i18n = {
    defaultLocale = "en_US.UTF-8";
    
    # extraLocaleSettings: Regional formats for specific categories
    # Using de_DE (German) for formats while keeping English UI
    # LC_TIME: Date/time format (24-hour clock, DD.MM.YYYY)
    # LC_MONETARY: Currency format (Euro with comma as decimal separator)
    # LC_NUMERIC: Number format (comma as decimal separator)
    # LC_MEASUREMENT: Metric system
    # LC_PAPER: Paper size (A4 instead of Letter)
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  # ----------------------------------------------------------------------------
  # Graphics and Hardware Acceleration
  # ----------------------------------------------------------------------------
  # services.xserver.videoDrivers: Specifies which GPU driver to load
  # "amdgpu": Open-source AMD GPU driver (recommended for modern AMD cards)
  # Alternative: "nvidia" for NVIDIA cards, "intel" for Intel integrated graphics
  # Reference: https://nixos.wiki/wiki/AMD_GPU
  services.xserver.videoDrivers = [ "amdgpu" ];

  # hardware.graphics (formerly hardware.opengl): Hardware-accelerated graphics rendering
  # Required for: Gaming, video playback, GPU-accelerated applications
  # Note: Renamed from hardware.opengl in NixOS 24.11+
  # Reference: https://nixos.wiki/wiki/OpenGL
  hardware.graphics = {
    enable = true;
    
    # enable32Bit: Enable 32-bit graphics libraries (formerly driSupport32Bit)
    # Required for: Steam (32-bit games), Wine, older games
    # Most modern games still use 32-bit libraries even on 64-bit systems
    # Note: driSupport is now always enabled and no longer needs to be set
    enable32Bit = true;
  };
}
