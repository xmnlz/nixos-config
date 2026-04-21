{ pkgs, ... }:

{
  home.packages = with pkgs; [
    typst
    zig
    bun
  ];
}
