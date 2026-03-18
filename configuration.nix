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

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };

  nix.gc = {
    automatic = true;
    persistent = true;
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
