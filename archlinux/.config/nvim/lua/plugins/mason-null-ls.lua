-- integration between mason and null-ls
return {
	"jay-babu/mason-null-ls.nvim",
	build = ":NullLsInstall",
	-- event = { "BufReadPre", "BufNewFile" },
	event = "VeryLazy",
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
	},
	opts = { automatic_installation = true },
}
