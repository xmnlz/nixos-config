{ pkgs, ... }:

{
  networking.networkmanager = {
    enable = true;
    wifi.powersave = false;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
    config.hyprland.default = [ "hyprland" "gtk" ];
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [ libva mesa ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    plemoljp
  ];

  fonts.fontconfig.defaultFonts = {
    monospace = [ "JetBrainsMono Nerd Font Mono" ];
  };

  services.upower.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  environment.systemPackages = with pkgs; [
    fish
  ];
}

