{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    inputs.helium.packages.${system}.default
  ];
}
