-- lsp hint as you type
local function config()
	local lsp_signature = require("lsp_signature")
	local set_hl = vim.api.nvim_set_hl

	set_hl(0, "FloatBorder", { link = "TelescopeBorder" })

	lsp_signature.setup({
		lsp_signature.on_attach({
			bind = true,
			doc_lines = 10,
			floating_window = true,
			fix_pos = true,
			hint_enable = false,
			hint_prefix = "",
			hi_parameter = "LspSignatureActiveParameter",
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
end

return {
	"ray-x/lsp_signature.nvim",
	event = "InsertEnter",
	config = config,
}
