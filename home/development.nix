{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Languages
    zig

    # LSP 
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

  programs.fish = {
    enable = true;
    shellAliases = {
      # nixos stuff
      nrs = "nixos-rebuild switch --flake .";
      nrb = "nixos-rebuild boot --flake .";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xmnlz";
        email = "lemmeq9@gmail.com";
      };
      core = {
        editor = "nvim";
      };
      init = {
        defaultBranch = "main";
      };
      credential = { 
        helper = "!gh auth git-credential";
      };
    };
  };
}
