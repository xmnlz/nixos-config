local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.enable({
  "nixd",
  "docker_language_server",
  "tailwindcss",
  "tinymist",
  "svelte",
  "lua_ls",
  "gopls",
  "tsgo",
  "html",
  "zls",
  "pyright",
  "qmlls",
  "biome",
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local bufnr = args.buf
    local builtin = require('telescope.builtin')

    local function map(key, fn)
      vim.keymap.set("n", key, fn, { noremap = true, silent = true, buffer = bufnr })
    end


    map("gr",
      function()
        builtin.lsp_references {
          show_line = true,
          include_current_line = false,
          include_declaration = false
        }
      end)

    map("gd", function() builtin.lsp_definitions { show_line = true } end)
    map("gI", function() builtin.lsp_implementations { show_line = true } end)
    map("<leader>D", function() builtin.lsp_type_definitions() end)
    map("<leader>rn", vim.lsp.buf.rename)
    map("<leader>ca", vim.lsp.buf.code_action)
    map("gD", vim.lsp.buf.declaration)
    map("K", vim.lsp.buf.hover)
  end,
})
