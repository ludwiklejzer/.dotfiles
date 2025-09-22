-- disable certain features on big files
return {
	"LunarVim/bigfile.nvim",
	event = "BufReadPre",
	opts = {
		filesize = 5,
		pattern = { "*" },
		features = {
			"indent_blankline",
			"illuminate",
			"lsp",
			"treesitter",
			"syntax",
			"matchparen",
			"vimopts",
			"filetype",
		},
	},
}
