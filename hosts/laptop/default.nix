{ inputs, ... }:

{
  # NixOS state version - DO NOT CHANGE after initial installation
  # Reference: https://nixos.org/manual/nixos/stable/#sec-upgrading
  system.stateVersion = "25.11";

  # System-level module imports
  # These configure the base NixOS system
  imports = [
    # Hardware configuration (auto-generated, contains disk/boot settings)
    ./hardware.nix

    # Host-specific system configuration (bootloader, networking, kernel)
    ./modules/system.nix
    
    # Host-specific services (fprintd, etc.)
    ./modules/services.nix

    # Shared NixOS modules across all hosts
    ../../modules/nixos/common.nix    # Common system settings (nix config, gc, locale)
    ../../modules/nixos/users.nix     # User account definitions
    ../../modules/nixos/gnome.nix     # GNOME desktop environment
    ../../modules/nixos/gaming.nix    # Gaming configuration (Steam, gamescope, etc.)
  ];

  # Home Manager configuration
  # Manages user-level configurations (dotfiles, user packages, etc.)
  # Reference: https://github.com/nix-community/home-manager
  home-manager.extraSpecialArgs = { inherit inputs; };

  home-manager.users.xmnlz = {
    imports = [
      ./home.nix
      inputs.vicinae.homeManagerModules.default
    ];
  };

}
