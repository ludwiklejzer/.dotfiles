local lspconfig = require("lspconfig")

-- signcolumn symbols
local function lspSymbol(name, icon)
	local hl = "DiagnosticSign" .. name
	vim.fn.sign_define(hl, { text = icon, numhl = hl, texthl = hl })
end

lspSymbol("Error", "")
lspSymbol("Info", "")
lspSymbol("Hint", "")
lspSymbol("Warn", "")

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
	virtual_text = false,
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
local servers = { "pylsp", "html", "cssls", "cssmodules_ls", "clangd", "yamlls", "bashls", "jsonls", "eslint" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup({
		on_attach = on_attach,
		capabilities = capabilities,
	})
end

-- Lua lsp config
lspconfig.sumneko_lua.setup({
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

-- Emmet lsp config
lspconfig.emmet_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	filetypes = { "html", "css", "javascriptreact", "javascript.jsx", "typescriptreact" },
})

lspconfig.sqls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
})
