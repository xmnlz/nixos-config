vim.lsp.enable({
	"dockerls",
	"tailwindcss",
	"tinymist",
	"svelte",
	"lua_ls",
	"gopls",
	"ts_ls",
	"html",
	"zls",
	"nil",
	"pyright",
	"qmlls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local bufnr = args.buf
		local opts = { noremap = true, silent = true, buffer = bufnr }

		-- Define keybindings
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
		vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
	end,
})
