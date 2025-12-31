{ config, pkgs, ... }:

{
  users.mutableUsers = false;

  users.users.xmnlz = {
    isNormalUser = true;
    description = "xmnlz";
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}
