{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    lua-language-server
    gopls
    tsserver
    tailwindcss-language-server
    svelte-language-server
    html-lsp
    docker-language-server
    zls
  ];
}

