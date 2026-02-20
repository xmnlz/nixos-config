{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Languages
    zig

    # LSP servers
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

  programs.git.config = {
    user = {
      name = "xmnlz";
      username = "xmnlz";
      email = "lemmeq9@gmail.com"
    };
  };
}
