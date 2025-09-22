-- auto close pairs (), [], {}, "", ''
local function config()
	local autopairs = require("nvim-autopairs")
	local cmp_autopairs = require("nvim-autopairs.completion.cmp")
	local cmp = require("cmp")

	autopairs.setup({
		fast_wrap = {},
		disable_filetype = { "TelescopePrompt", "vim" },
	})

	cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	config = config,
}
