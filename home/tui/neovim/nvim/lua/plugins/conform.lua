local conform = require("conform")

conform.setup({
  format_after_save = {
    lsp_format = "fallback",
  },

  notify_on_error = true,
  notify_no_formatters = true,

  formatters_by_ft = {
    nix = { "alejandra", "nixfmt", stop_after_first = true },

    c = { "clang-format" },
    cpp = { "clang-format" },
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    go = { "gofmt" },
    lua = { "stylua" },

    java = { "google-java-format" },
    kotlin = { "ktlint" },

    javascript = { "biome", "prettierd", "prettier", stop_after_first = true },
    typescript = { "biome", "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "biome", "prettierd", "prettier", stop_after_first = true },

    svelte = { "biome", "prettierd", "prettier", stop_after_first = true },
    astro = { "biome", "prettierd", "prettier", stop_after_first = true },
    css = { "biome", "prettierd", "prettier", stop_after_first = true },
    html = { "htmlbeautifier" },

    json = { "biome", "prettierd", "prettier", stop_after_first = true },
    yaml = { "yamlfix" },
    toml = { "taplo" },
    proto = { "buf" },
    markdown = { "prettierd", "prettier", stop_after_first = true },
    ["_"] = { "trim_whitespace" },
  },
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
  conform.format({ async = true, lsp_format = "fallback" })
end)
