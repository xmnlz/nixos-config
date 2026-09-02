local conform = require("conform")

conform.setup({
  format_after_save = {
    lsp_format = "fallback",
  },

  notify_on_error = true,
  notify_no_formatters = true,

  formatters = {
    biome = {
      -- forces the nix store path
      command = vim.fn.exepath("biome"),
      require_cwd = false,
    },
    -- `biome check --write`: formats AND sorts imports + safe fixes
    ["biome-check"] = {
      command = vim.fn.exepath("biome"),
      require_cwd = false,
    },
  },

  formatters_by_ft = {
    nix = { "alejandra" },

    c = { "clang-format" },
    cpp = { "clang-format" },
    lua = { "stylua" },

    -- these ship with their toolchain, so they resolve inside the project devshell
    rust = { "rustfmt" },
    zig = { "zigfmt" },
    go = { "gofmt" },

    kotlin = { "ktlint" },

    javascript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    typescript = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    javascriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    typescriptreact = { "biome-check", "prettierd", "prettier", stop_after_first = true },

    svelte = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    astro = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    css = { "biome-check", "prettierd", "prettier", stop_after_first = true },
    html = { "prettierd", "prettier", stop_after_first = true },

    json = { "biome-check", "prettierd", "prettier", stop_after_first = true },
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
