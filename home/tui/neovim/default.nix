{ pkgs, ... }:
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

      # NOTE: Treesetter is here just for the queries
      (nvim-treesitter.withPlugins (p: map (lang: p.${lang}) [
        "lua" "nix" "python" "rust"
        "typescript" "tsx" "javascript"
        "bash" "go" "zig" "kotlin"
        "html" "css" "svelte" "dockerfile"
        "json" "yaml" "toml"
        "markdown" "markdown_inline"
      ]))
    ];
  };

  xdg.configFile."nvim".source = ./nvim;
}
