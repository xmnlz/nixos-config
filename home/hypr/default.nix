{ pkgs, ... }:

{
  xdg.configFile."hypr/hyprland.conf".source = ./hyprland.conf;
  xdg.configFile."hypr/xdph.conf".text = '' 
  screencopy {
    allow_token_by_default = true
  }
  '';
}
