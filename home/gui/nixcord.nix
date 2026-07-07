{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord = {
      krisp.enable = true;
      silenceNoModClientWarning = true;
    };
  };
}
