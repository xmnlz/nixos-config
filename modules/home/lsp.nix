{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    gopls
    lua-language-server
    typescript-language-server
    tailwindcss-language-server
    svelte-language-server
    docker-language-server
    pyright
    zls
  ];
}

