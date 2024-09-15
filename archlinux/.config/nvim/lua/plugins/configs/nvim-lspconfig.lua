-- setup neodev for nvim lua
local lspconfig = require("lspconfig")
require("neodev").setup()

local handlers = {
	{ "hover", "hover" },
}

for _, handler in pairs(handlers) do
	vim.lsp.handlers["textDocument/" .. handler[1]] = vim.lsp.with(vim.lsp.handlers[handler[2]], {
		border = "single",
	})
end

vim.diagnostic.config({
	float = {
		source = "always",
	},
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

-- suppress error messages from lang servers
vim.notify = function(msg, log_level)
	if msg:match("exit code") then
		return
	end
	if log_level == vim.log.levels.ERROR then
		vim.api.nvim_err_writeln(msg)
	else
		vim.api.nvim_echo({ { msg } }, true, {})
	end
end

local on_attach = function(_, bufnr)
	vim.api.nvim_create_autocmd("CursorHold", {
		buffer = bufnr,
		callback = function()
			local opts = {
				focusable = false,
				close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
				border = "single",
				source = "always",
				prefix = "",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Enable the following language servers with default configs
local servers = {
	"gdscript",
	"html",
	"cssls",
	"cssmodules_ls",
	"css_variables",
	"bashls",
	"eslint",
	"awk_ls",
	"marksman",
	"dockerls",
	"docker_compose_language_service",
	"vuels",
	"sqls",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

lspconfig.jedi_language_server.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})

lspconfig.pylsp.setup({
	on_attach = on_attach,
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

-- lspconfig.pyright.setup({
-- 	on_attach = on_attach,
-- 	capabilities = capabilities,
-- 	handlers = {
-- 		-- disable hover
-- 		["textDocument/hover"] = function() end,
-- 	},
-- })

-- Lua lsp config
lspconfig.lua_ls.setup({
	on_attach = on_attach,
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

lspconfig.jsonls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		json = {
			schemas = require("schemastore").json.schemas(),
			validate = { enable = true },
		},
	},
})

lspconfig.yamlls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		yaml = {
			schemaStore = { enable = false, url = "" },
			schemas = require("schemastore").yaml.schemas(),
		},
	},
})

-- Javascript lsp config
lspconfig.tsserver.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = {
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
})

-- clangd lsp config
lspconfig.clangd.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = {
		"clangd",
		"--offset-encoding=utf-16",
	},
})

-- Emmet lsp config
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "javascriptreact", "javascript.jsx", "typescriptreact", "vue" },
})

-- custom qml lsp
local server_config = require("lspconfig.configs")

server_config.qmlls = {
	default_config = {
		cmd = { "qmlls6", "--build-dir", "~/.cache" },
		name = "qmlls",
		filetypes = { "qml" },
		root_dir = function()
			return vim.loop.cwd()
		end,
	},
}

require("lspconfig").qmlls.setup({})
