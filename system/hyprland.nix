{ pkgs, ... }:

{
  programs.hyprland = {
    enable = true;
  };

  # Essential packages for Hyprland
  environment.systemPackages = with pkgs; [
    # Clipboard
    wl-clipboard
  ];
}
