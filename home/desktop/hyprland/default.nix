{...}: {
  imports = [./uwsm.nix];

  xdg.configFile = {
    "hypr/hyprland.lua".source = ./hyprland.lua;

    "hypr/config" = {
      source = ./config;
      recursive = true;
    };

    "hypr/xdph.conf".text = ''
      screencopy {
        allow_token_by_default = true
      }
    '';
  };
}
