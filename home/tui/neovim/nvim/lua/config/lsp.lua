local capabilities = require('blink.cmp').get_lsp_capabilities()

vim.lsp.config('*', { capabilities = capabilities })

vim.lsp.enable({
  "nixd",
  "dockerls",
  "tailwindcss",
  "tinymist",
  "svelte",
  "lua_ls",
  "gopls",
  "tsgo",
  -- "ts_ls",
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
    local function map(key, fn, desc)
      vim.keymap.set("n", key, fn, { noremap = true, silent = true, buffer = bufnr, desc = desc })
    end

    -- These three get Telescope pickers with live preview
    map("gd", function()
      builtin.lsp_definitions { initial_mode = "normal", show_line = true }
    end, "Go to definition")

    map("gr", function()
      builtin.lsp_references {
        initial_mode         = "normal",
        show_line            = true,
        include_current_line = false,
        include_declaration  = false,
      }
    end, "References")

    map("gI", function()
      builtin.lsp_implementations { initial_mode = "normal", show_line = true }
    end, "Implementations")

    map("<leader>D", function()
      builtin.lsp_type_definitions { initial_mode = "normal" }
    end, "Type definition")

    -- These stay as raw LSP calls — no picker needed
    map("<leader>rn", vim.lsp.buf.rename, "Rename")
    map("<leader>ca", vim.lsp.buf.code_action, "Code action")
    map("gD", vim.lsp.buf.declaration, "Declaration")
    map("K", vim.lsp.buf.hover, "Hover docs")

    -- Bonus: symbol search in current file
    map("<leader>ls", function()
      builtin.lsp_document_symbols { symbol_width = 40 }
    end, "Document symbols")
  end,
})
-- vim.api.nvim_create_autocmd("LspAttach", {
--   callback = function(args)
--     local bufnr = args.buf
--     local opts = { noremap = true, silent = true, buffer = bufnr }
--
--     -- existing keymaps
--     vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
--     vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
--     vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
--     vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
--     vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
--     vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
--     vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
--   end,
-- })
