{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;

    autoPrune = {
      enable = true;
      persistent = true;
      flags = [ "--all" ];
    };
  };
}
