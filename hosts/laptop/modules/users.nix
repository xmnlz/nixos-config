{ config, pkgs, inputs, ... }:

{
  users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = [ "networkmanager" "wheel" ];
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
