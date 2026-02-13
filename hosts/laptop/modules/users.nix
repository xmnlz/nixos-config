{ config, pkgs, inputs, ... }:

{
  users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      # Disable GNOME’s default Super+Space (input source switcher)
      switch-input-source = [];
      switch-input-source-backward = [];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vicinae/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/vicinae" = {
      name = "Vicinae";
      command = "vicinae";
      binding = "<Super>space";
    };
  };

  users.users.greeter = {
    isSystemUser = true;
    home = "/var/lib/greeter";
    createHome = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      xmnlz = import ../home.nix;
    };
  };
}
