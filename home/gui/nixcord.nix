{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  programs.nixcord = {
    enable = true;
    discord = {
      vencord = {
        enable = true;
        package = pkgs.vencord;
      };
      krisp.enable = true;

      settings = {
        SKIP_HOST_UPDATE = true;
      };
    };
  };
}
