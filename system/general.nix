{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

  ];

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    material-symbols
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font Mono" ];
  };

  qt = {
    enable = true;
  };



  services.fprintd.enable = true;

  networking = {
    hostName = "xmnlz";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
    };
  };

  # Uncomment to enable fingerprint auth in PAM (test carefully to avoid lockout)
  # security.pam.services = {
  #   login.fprintAuth = true;
  #   sudo.fprintAuth = true;
  #   greetd.fprintAuth = true;
  # };

  # Uncomment to use greetd instead of GDM (also disable GDM in system/gnome.nix)
  # If enabling greetd, also add:
  #   users.users.greeter = { isSystemUser = true; group = "greeter"; };
  #   users.groups.greeter = {};
  # services.greetd = {
  #   enable = true;
  #   settings.default_session = {
  #     command = "Hyprland";
  #     user = "greeter";
  #   };
  # };
}

