{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # lsp binaries
    extraPackages = with pkgs; [
      nixd

      typescript-language-server
      svelte-language-server
      vscode-langservers-extracted
      tailwindcss-language-server

      lua-language-server

      zls
      gopls
      qt6.qtdeclarative

      tinymist

      docker-language-server

      pyright
    ];

    plugins = with pkgs.vimPlugins; [
      neomodern-nvim

      nvim-lspconfig
      nvim-cmp

      telescope-nvim
      telescope-ui-select-nvim
      plenary-nvim

      (nvim-treesitter.withPlugins (p: [
        p.lua
        p.nix
        p.python
        p.rust
        p.typescript
        p.tsx
        p.javascript
        p.bash
        p.go
        p.zig
        p.html
        p.css
        p.svelte
        p.dockerfile
        p.json
        p.yaml
        p.toml
        p.markdown
        p.markdown_inline
      ]))
    ];
  };

  xdg.configFile."nvim".source = ./nvim;
}
