-- change commentstring according to the lang
return {
	"JoosepAlviste/nvim-ts-context-commentstring",
	keys = { { "gc", mode = "v" }, "gcc", "gbc" },
	config = function()
		require("Comment").setup({
			pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
		})
	end,
}
