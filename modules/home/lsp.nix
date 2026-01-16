{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    nil
    gopls
    tinymist
    lua-language-server
    typescript-language-server
    tailwindcss-language-server
    svelte-language-server
    docker-language-server
    vscode-langservers-extracted
    pyright
    zls
  ];
}

