local lspconfig = require("lspconfig")

-- signcolumn symbols
local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

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
	signs = true,
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
				prefix = " ",
				scope = "cursor",
			}
			vim.diagnostic.open_float(nil, opts)
		end,
	})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Enable the following language servers with default configs
local servers = {
	"gdscript",
	"pyright",
	-- "jedi_language_server",
	-- "pylsp",
	"html",
	"cssls",
	"cssmodules_ls",
	"yamlls",
	"bashls",
	"jsonls",
	"eslint",
}

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- LanguageTool
local function getDictWords()
	local path = vim.fn.stdpath("config") .. "/spell/words.utf-8.add"
	local words = {}

	for word in io.open(path, "r"):lines() do
		table.insert(words, word)
	end

	return words
end

lspconfig.ltex.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	cmd = { "ltex-ls" },
	filetypes = { "tex", "latex" },
	flags = { debounce_text_changes = 300 },
	trace = { server = "verbose" },
	settings = {
		ltex = {
			language = "en-US",
			-- language = "pt-BR",
			completionEnabled = true,
			checkFrequency = "save",
			enabled = {
				"bibtex",
				"context",
				"context.tex",
				"html",
				"latex",
				"markdown",
				"org",
				"restructuredtext",
				"rsweave",
			},
			diagnosticSeverity = {
				PASSIVE_VOICE = "hint",
				PASSIVE_VOICE_SIMPLE = "hint",
				SINGULAR_AGREEMENT_SENT_START = "error",
				AGREEMENT_SENT_START = "error",
				ADMIT_ENJOY_VB = "error",
				EN_A_VS_AN = "error",
				PUNCTUATION_PARAGRAPH_END = "error",
				UPPERCASE_SENTENCE_START = "error",
				HUNSPELL_RULE = "error",
				GENERAL_GENDER_AGREEMENT_ERRORS = "error",
				default = "information",
			},
			setenceCacheSize = 2000,
			additionalRules = {
				enablePickyRules = true,
				motherTongue = "pt-BR",
			},
			dictionary = {
				["en-US"] = getDictWords(),
				["pt-BR"] = getDictWords(),
			},
		},
	},
})

-- Lua lsp config
lspconfig.lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
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
	-- run lsp for javascript in any directory
	-- root_dir = function() return vim.loop.cwd() end,
	root_dir = function()
		return vim.loop.cwd()
	end,
	preferences = {
		quotePreference = "single",
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
	filetypes = { "html", "css", "javascriptreact", "javascript.jsx", "typescriptreact" },
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
