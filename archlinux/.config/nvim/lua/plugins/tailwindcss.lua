-- tailwind-tools.lua
return {
	"luckasRanarison/tailwind-tools.nvim",
	event = "InsertEnter",
	name = "tailwind-tools",
	build = ":UpdateRemotePlugins",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-telescope/telescope.nvim",
		"neovim/nvim-lspconfig",
	},
	opts = {},
}
