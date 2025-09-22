-- integration between lspconfig and mason
return {
	"williamboman/mason-lspconfig.nvim",
	-- lazy = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "mason.nvim" },
	opts = {
		-- ensure_installed = {
		-- 	"bashls",
		-- 	"cssls",
		-- 	"cssmodules_ls",
		-- 	"emmet_ls",
		-- 	"eslint",
		-- 	"html",
		-- 	"jsonls",
		-- 	"ltex",
		-- 	"lua_ls",
		-- 	"pyright",
		-- 	"tsserver",
		-- 	"yamlls",
		-- },
	},
}
