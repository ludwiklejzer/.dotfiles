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
