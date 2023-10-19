local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local hover = null_ls.builtins.hover
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.shellharden,
		formatting.shfmt,
		formatting.black,
		formatting.yamlfmt,
		formatting.sql_formatter,
		formatting.clang_format,
		formatting.gdformat,

		-- code_actions.eslint,
		-- diagnostics.eslint,
		diagnostics.cpplint.with({
			args = { "--filter=-whitespace/tab", "$FILENAME" },
		}),
		diagnostics.shellcheck,
		-- diagnostics.gdlint,
		hover.dictionary,
	},

	-- This is the most reliable way to format on save, since it blocks Neovim until results are applied
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						bufnr = bufnr,
						filter = function(client)
							return client.name == "null-ls"
						end,
					})
				end,
			})
		end

		-- float window configs
		vim.api.nvim_create_autocmd("CursorHold", {
			buffer = bufnr,
			callback = function()
				local opts = {
					focusable = false,
					close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
					border = "single",
					source = "always",
					prefix = " ",
					scope = "cursor",
				}
				vim.diagnostic.open_float(nil, opts)
			end,
		})
	end,
})

-- custom qml formatting
-- local qmlformat = {
-- 	method = null_ls.methods.FORMATTING,
-- 	filetypes = { "qml" },
-- 	generator = null_ls.formatter({
-- 		command = "qmlformat",
-- 		args = { "$FILENAME" },
-- 		to_stdin = true,
-- 		from_stderr = true,
-- 	}),
-- }
-- null_ls.register(qmlformat)
