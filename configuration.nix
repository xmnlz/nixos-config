{ inputs, ... }:

{
  imports = [
    ./hardware.nix
    ./system/boot.nix
    ./system/general.nix
    ./system/gnome.nix
    ./system/hyprland.nix
    ./system/gaming.nix
  ];

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    
    # Binary caches
    substituters = [
      "https://hyprland.cachix.org"
      "https://vicinae.cachix.org"
    ];

    trusted-substituters = [
      "https://hyprland.cachix.org"
      "https://vicinae.cachix.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc="
    ];
  };

  nixpkgs.config.allowUnfree = true;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # Localization
  time.timeZone = "Europe/Berlin";

  i18n = {
    defaultLocale = "en_US.UTF-8";
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

  # User account
  users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = [ "wheel" "networkmanager" ];
  };


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      xmnlz = import ./home.nix;
    };
  };

  system.stateVersion = "25.11";
}
