{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # FIXME: Waiting for a pr to be merged
    # https://github.com/NixOS/nixpkgs/pull/514596
    # anytype
  ];
}
