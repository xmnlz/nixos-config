{ pkgs, ... }:

{
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Terminal
    kitty

    # Clipboard
    wl-clipboard
  ];
}
