{ pkgs, ... }:

{
  # Enable Hyprland
  wayland.windowManager.hyprland.enable = true;
  programs.kitty.enable = true;

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty
    
    # Launcher
    wofi
    
    # Notifications
    mako
    
    # Screenshot
    grim
    slurp
    
    # Status bar
    waybar
    
    # Clipboard
    wl-clipboard
  ];
}
