local lsp_signature = require("lsp_signature")

lsp_signature.setup({
	lsp_signature.on_attach({
		bind = true,
		doc_lines = 0,
		floating_window = true,
		fix_pos = true,
		hint_enable = false,
		hint_prefix = "",
		hi_parameter = "TSAttribute",
		max_height = 22,
		max_width = 70,
		handler_opts = {
			border = "single",
		},
		zindex = 200,
		padding = " ",
		shadow_enabled = true,
	}),
})
