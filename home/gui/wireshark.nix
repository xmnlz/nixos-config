{ pkgs, ... }:

{
  # FIXME: https://github.com/NixOS/nixpkgs/issues/296804
  home.packages = with pkgs; [
    # wireshark
  ];
}
