local function config()
	local lspconfig = require("lspconfig")

	vim.diagnostic.config({
		float = { source = true },
		virtual_text = true,
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = "",
				[vim.diagnostic.severity.WARN] = "",
				[vim.diagnostic.severity.INFO] = "",
				[vim.diagnostic.severity.HINT] = "",
			},
		},
		underline = true,
		update_in_insert = false,
	})

	-- override borders globally
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview

	---@diagnostic disable-next-line: duplicate-set-field
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or "single"
		opts.max_width = opts.max_width or 75
		opts.max_height = opts.max_height or 15
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true

	-- Enable the following language servers with default configs
	local servers = {
		"hyprls",
		"gdscript",
		"cssmodules_ls",
		"css_variables",
		"bashls",
		"eslint",
		"dockerls",
		"docker_compose_language_service",
		"tailwindcss",
		"dartls",
		"emmet_language_server",
	}

	for _, lsp in ipairs(servers) do
		lspconfig[lsp].setup({
			capabilities = capabilities,
		})
	end

	lspconfig.beancount.setup({
		capabilities = capabilities,
		init_options = {
			journal_file = "/home/ludwiklejzer/beancount/main.beancount",
		},
	})

	lspconfig.html.setup({
		filetypes = { "html" },
		init_options = {
			provideFormatter = true,
			embeddedLanguages = {
				css = true,
				javascript = true,
			},
		},
	})

	lspconfig.stylelint_lsp.setup({
		capabilities = capabilities,

		settings = {
			stylelintplus = {
				autoFixOnSave = true,
			},
			root_dir = function()
				return vim.loop.cwd()
			end,
		},
	})

	lspconfig.jedi_language_server.setup({
		capabilities = capabilities,
	})

	lspconfig.pylsp.setup({
		capabilities = capabilities,
		handlers = {
			-- disable hover
			["textDocument/hover"] = function() end,
		},
		settings = {
			pylsp = {
				plugins = {
					rope = { enabled = true },
					flake8 = { enabled = true },
					mccabe = { enabled = true },
					pycodestyle = { enabled = true },
					pydocstyle = { enabled = true },
					pyflakes = { enabled = false },
				},
			},
		},
	})

	-- Lua lsp config
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		settings = {
			Lua = {
				hint = { enable = true },
				diagnostics = {
					globals = { "vim" },
				},
			},
		},
	})

	lspconfig.rust_analyzer.setup({
		capabilities = capabilities,
		settings = {
			["rust-analyzer"] = {
				assist = {
					importEnforceGranularity = true,
					importPrefix = "crate",
				},
				check = { command = "clippy" },
				cargo = { allFeatures = true },
				checkOnSave = true,
				inlayHints = { locationLinks = false },
				diagnostics = {
					enable = true,
					experimental = { enable = true },
				},
			},
		},
	})

	lspconfig.jsonls.setup({
		capabilities = capabilities,
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})

	lspconfig.yamlls.setup({
		capabilities = capabilities,
		settings = {
			yaml = {
				schemaStore = { enable = false, url = "" },
				schemas = require("schemastore").yaml.schemas(),
			},
		},
	})

	lspconfig.cssls.setup({
		capabilities = capabilities,
		settings = {
			-- ignore UnknownAtRules error
			css = { validate = true, lint = { unknownAtRules = "ignore" } },
			scss = { validate = true, lint = { unknownAtRules = "ignore" } },
			less = { validate = true, lint = { unknownAtRules = "ignore" } },
		},
	})

	-- Javascript lsp config
	lspconfig.ts_ls.setup({
		capabilities = capabilities,
		filetypes = {
			"html",
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"typescript",
			"typescriptreact",
			"typescript.tsx",
		},

		root_dir = lspconfig.util.root_pattern("tsconfig.json", "jsconfig.json", "package.json", ".git"),
		preferences = {
			quotePreference = "double",
		},
		settings = {
			typescript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
			javascript = {
				inlayHints = {
					includeInlayParameterNameHints = "all",
					includeInlayParameterNameHintsWhenArgumentMatchesName = true,
					includeInlayFunctionParameterTypeHints = true,
					includeInlayVariableTypeHints = true,
					includeInlayPropertyDeclarationTypeHints = true,
					includeInlayFunctionLikeReturnTypeHints = true,
					includeInlayEnumMemberValueHints = true,
				},
			},
		},
	})

	-- clangd lsp config
	lspconfig.clangd.setup({
		capabilities = capabilities,
		cmd = {
			"clangd",
			"--offset-encoding=utf-16",
		},
	})

	-- custom qml lsp
	local server_config = require("lspconfig.configs")

	server_config.qmlls = {
		default_config = {
			cmd = { "qmlls6", "--build-dir", "~/.cache" },
			name = "qmlls",
			filetypes = { "qml", "qmljs" },
			root_dir = function()
				return vim.loop.cwd()
			end,
		},
	}

	require("lspconfig").qmlls.setup({})
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = config,
}
