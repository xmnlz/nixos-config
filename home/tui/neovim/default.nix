{ pkgs, ... }:
let
  grammars = pkgs.vimPlugins.nvim-treesitter.builtGrammars;
  treesitterGrammars = map (lang: grammars.${lang}) [
    "lua" "nix" "python" "rust"
    "typescript" "tsx" "javascript"
    "bash" "go" "zig" "kotlin"
    "html" "css" "svelte" "dockerfile"
    "json" "yaml" "toml"
    "markdown" "markdown_inline"
  ];
in
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      nixd
      typescript-language-server
      svelte-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      lua-language-server
      zls gopls tinymist
      docker-language-server
      pyright
      qt6.qtdeclarative
      pkgs.kdePackages.qt5compat
    ];

    plugins = with pkgs.vimPlugins; [
      neomodern-nvim
      blink-cmp
      nvim-lspconfig
      telescope-nvim
      telescope-ui-select-nvim
      plenary-nvim
    ] ++ treesitterGrammars;
  };

  xdg.configFile."nvim".source = ./nvim;
}
