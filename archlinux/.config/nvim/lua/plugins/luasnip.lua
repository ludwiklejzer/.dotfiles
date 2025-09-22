-- snippets engine
local function config()
	local luasnip = require("luasnip")

	luasnip.config.set_config({
		history = false,
		updateevents = "TextChanged,TextChangedI",
	})

	-- insert html snippets in js files
	luasnip.filetype_extend("html", { "javascript" })
	luasnip.filetype_extend("javascriptreact", { "html" })
	luasnip.filetype_extend("typescriptreact", { "html" })

	require("luasnip.loaders.from_vscode").load()
	require("luasnip.loaders.from_vscode").lazy_load({ paths = { vim.fn.stdpath("config") .. "/snippets" } })

	-- load javascript snippets into typescript files
	require("luasnip").filetype_extend({ "typescript", "typescriptreact", "javascriptreact" }, { "javascript" })
end

return {
	"L3MON4D3/LuaSnip",
	event = "InsertEnter",
	version = "v2.*",
	build = "make install_jsregexp",
	dependencies = "rafamadriz/friendly-snippets", -- snippets library
	config = config,
}
