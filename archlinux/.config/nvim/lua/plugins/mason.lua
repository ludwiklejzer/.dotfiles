-- manage LSP servers, DAP servers, linters, and formatters
return {
	"williamboman/mason.nvim",
	cmd = { "Mason", "MasonInstall", "MasonLog", "MasonInstallAll", "MasonUpdate" },
	opts = {
		ui = {
			icons = {
				server_installed = "✓",
				server_pending = "➜",
				server_uninstalled = "✗",
			},
			border = "single",
		},
	},
}
