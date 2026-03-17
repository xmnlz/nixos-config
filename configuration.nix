{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./system/boot.nix
    ./system/general.nix
    ./system/hyprland.nix
    ./system/gnome.nix
  ];

  system.stateVersion = "26.05";

  # Nix settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;

  # Automatic garbage collection
  nix.gc = {
    automatic = true;
    persistent = true;
    dates = "weekly";
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

  # TODO: Find a better way to do so 
  programs.fish.enable = true;

  users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = { inherit inputs; };
    users = {
      xmnlz = import ./home.nix;
    };
  };

}
