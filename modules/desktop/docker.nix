{ ... }:

{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    socketActivation = true;

    autoPrune = {
      enable = true;
      persistent = true;
      flags = [ "--all" ];
    };
  };
}
