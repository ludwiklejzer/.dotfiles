return {
	"mistweaverco/kulala.nvim",
	keys = {
		{ "<leader>Rs", desc = "Send request" },
		{ "<leader>Ra", desc = "Send all requests" },
		{ "<leader>Rb", desc = "Open scratchpad" },
	},
	ft = { "http", "rest" },
	opts = {
		global_keymaps = true,
		global_keymaps_prefix = "<leader>R",
		kulala_keymaps_prefix = "",
		split_direction = "horizontal",
		ui = { winbar = false },
		lsp = {
			on_attach = function(_, bufnr)
				local fmt_grp = vim.api.nvim_create_augroup("KulalaFormatOnSave", { clear = false })
				vim.api.nvim_clear_autocmds({ group = fmt_grp, buffer = bufnr })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = fmt_grp,
					buffer = bufnr,
					desc = "Format Kulala supported files on save",
					callback = function()
						vim.lsp.buf.format({
							bufnr = bufnr,
							async = false,
							timeout_ms = 2000,
							filter = function(c)
								return c.name == "kulala"
							end,
						})
					end,
				})
			end,
		},
	},
}
