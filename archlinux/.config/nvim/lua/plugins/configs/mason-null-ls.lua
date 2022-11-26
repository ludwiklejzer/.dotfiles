require("mason-null-ls").setup({
	ensure_installed = {
		"black",
		"prettier",
		"shellcheck",
		"shellharden",
		"shfmt",
		"stylua",
		"yaml-language-server",
		"yamlfmt",
	},
})
