{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # lsp's
      nixd
      pyright
      typescript-language-server
      typescript-go
      svelte-language-server
      vscode-langservers-extracted
      tailwindcss-language-server
      lua-language-server
      zls
      gopls
      tinymist
      docker-language-server
      pyright
      qt6.qtdeclarative
      pkgs.kdePackages.qt5compat

      # formaters's
      alejandra
    ];

    plugins = with pkgs.vimPlugins; [
      neomodern-nvim
      blink-cmp
      conform-nvim
      nvim-lspconfig
      telescope-nvim
      telescope-ui-select-nvim
      telescope-fzf-native-nvim
      plenary-nvim
      gitsigns-nvim
      diffview-nvim

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
        p.kotlin
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

  xdg.desktopEntries.nvim = {
    name = "Neovim";
    genericName = "Text Editor";
    exec = "alacritty -e nvim %F";
    icon = "nvim";
    terminal = false;
    categories = ["Utility" "TextEditor"];
    mimeType = [
      "text/plain"
      "text/markdown"
      "text/css"
      "text/javascript"
      "text/x-python"
      "text/x-lua"
      "text/x-csrc"
      "text/x-chdr"
      "text/x-c++src"
      "text/x-c++hdr"
      "text/x-go"
      "text/x-rust"
      "text/x-sql"
      "application/json"
      "application/xml"
      "application/x-yaml"
      "application/toml"
      "application/x-shellscript"
    ];
  };

  xdg.mimeApps.defaultApplications = {
    "text/plain" = ["nvim.desktop"];
    "text/markdown" = ["nvim.desktop"];
    "text/css" = ["nvim.desktop"];
    "text/javascript" = ["nvim.desktop"];
    "text/x-python" = ["nvim.desktop"];
    "text/x-lua" = ["nvim.desktop"];
    "text/x-csrc" = ["nvim.desktop"];
    "text/x-chdr" = ["nvim.desktop"];
    "text/x-c++src" = ["nvim.desktop"];
    "text/x-c++hdr" = ["nvim.desktop"];
    "text/x-go" = ["nvim.desktop"];
    "text/x-rust" = ["nvim.desktop"];
    "text/x-sql" = ["nvim.desktop"];
    "application/json" = ["nvim.desktop"];
    "application/xml" = ["nvim.desktop"];
    "application/x-yaml" = ["nvim.desktop"];
    "application/toml" = ["nvim.desktop"];
    "application/x-shellscript" = ["nvim.desktop"];
  };
}
