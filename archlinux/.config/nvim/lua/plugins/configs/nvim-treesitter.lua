local options = {
	context_commentstring = { enable = true },
	fold = { enable = true, patterns = {} },
	indent = { enable = true },
	highlight = { enable = true, use_languagetree = true },
	ensure_installed = {
		"lua",
		"c",
		"make",
		"qmljs",
		"qmldir",
		"html",
		"rasi",
		"css",
		"scss",
		"diff",
		"sql",
		"json",
		"jsonc",
		"javascript",
		"tsx",
		"typescript",
		"bash",
		"python",
		"markdown_inline",
		"yaml",
		"vue",
		"vim",
		"dockerfile",
		"norg",
		"git_config",
		"gitcommit",
		"git_rebase",
		"gitignore",
		"gitattributes",
		"dap_repl",
	},
}

return options
