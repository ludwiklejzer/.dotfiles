-- inject LSP diagnostics, code actions, and more
local function config()
	local null_ls = require("null-ls")
	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics
	local code_actions = null_ls.builtins.code_actions
	local hover = null_ls.builtins.hover
	local completion = null_ls.builtins.completion
	local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

	null_ls.setup({
		debug = true,
		sources = {
			-- completion.spell,
			completion.tags,
			formatting.prettier,
			formatting.stylua,
			-- formatting.shellharden,
			formatting.shfmt,
			formatting.black,
			formatting.isort,
			formatting.yamlfmt,
			formatting.sql_formatter,
			formatting.clang_format,
			-- formatting.gdformat,
			formatting.dart_format,
			-- formatting.qmlformat,
			-- formatting.gofmt,
			formatting.gofumpt,
			formatting.golines,
			formatting.bean_format,
			formatting.dxfmt,
			formatting.sqlfluff.with({ extra_args = { "--dialect", "sqlite" } }),
			diagnostics.mypy,
			diagnostics.checkmake,
			diagnostics.hadolint,
			diagnostics.sqlfluff.with({ extra_args = { "--dialect", "sqlite" } }),
			-- diagnostics.gdlint,
			diagnostics.yamllint,
			hover.dictionary,
			hover.printenv,
			code_actions.gitsigns,
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
							async = false,
							-- filter = function(c)
							-- 	return c.name == "null-ls"
							-- end,
							timeout_ms = 2000,
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
end

return {
	"nvimtools/none-ls.nvim",
	event = "InsertEnter",
	keys = { "K", " ca", "gi" },
	config = config,
}
