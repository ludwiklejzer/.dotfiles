local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name, clear)
	return vim.api.nvim_create_augroup(name, { clear = clear })
end

-- Open a file from its last left off position
autocmd({ "BufReadPost" }, {
	group = augroup("OpenLastPosition"),
	pattern = "*",
	command = "autocmd FileType <buffer> ++once "
		.. "if &ft !~# 'commit\\|rebase' && "
		.. 'line("\'\\"") > 1 && '
		.. 'line("\'\\"") <= line("$") | exe \'normal! g`"\' | endif',
})

-- Overwrite folding fillchars from orgmode plugin
autocmd({ "FileType" }, {
	group = augroup("OrgFillchars"),
	pattern = "org",
	callback = function()
		vim.opt_local.fillchars:append("fold:·")
	end,
})

-- Enable treesitter highlight for md and qml files
autocmd({ "FileType" }, {
	group = augroup("TSEnable"),
	pattern = { "markdown", "qml" },
	callback = function()
		vim.cmd("TSEnable highlight")
	end,
})

-- Overwrite org highlight colors
autocmd({ "FileType" }, {
	group = augroup("OrgHiColors"),
	pattern = "org",
	callback = function()
		vim.cmd([[
		hi link @org.priority.highest.org Constant
		]])
	end,
})

-- load treesitter highlight in norg files
autocmd({ "FileType" }, {
	group = augroup("LoadTreesitterNorg"),
	pattern = "norg",
	callback = function()
		vim.cmd("TSBufEnable highlight")
		vim.cmd("hi @neorg.tags.ranged_verbatim.code_block guibg=#222222")
	end,
})

-- persistent folding
autocmd({ "BufWinEnter" }, {
	group = augroup("AutoLoadFolding"),
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "i" and vim.fn.expand("%:t") ~= "" then
			vim.cmd("silent! loadview")
		end
	end,
})

autocmd({ "BufWinLeave" }, {
	group = augroup("AutoSaveFolding"),
	pattern = "*",
	callback = function()
		if vim.fn.mode() ~= "i" and vim.fn.expand("%:t") ~= "" then
			vim.cmd("silent! mkview")
		end
	end,
})

-- meaningful backup name
autocmd({ "BufWritePre" }, {
	group = augroup("BackupName"),
	pattern = "*",
	callback = function()
		vim.opt_local.bex = "@" .. os.date("%F")
	end,
})

-- remove line numbers from terminal and some filetypes
autocmd({ "TermOpen" }, {
	group = augroup("RemoveTerminalLineNr"),
	pattern = { "*" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
		-- vim.cmd("startinsert")
	end,
})
autocmd({ "FileType" }, {
	group = augroup("RemoveLineNr"),
	pattern = { "qf" },
	callback = function()
		vim.opt_local.number = false
		vim.opt_local.relativenumber = false
	end,
})

-- refresh lualine when resizing
autocmd({ "VimResized" }, {
	group = augroup("RefreshResizeLualine"),
	pattern = { "*" },
	callback = function()
		require("lualine").refresh()
	end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		local current_tab = vim.fn.tabpagenr()
		vim.cmd("tabdo wincmd =")
		vim.cmd("tabnext " .. current_tab)
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"man",
		"lspinfo",
		"notify",
		"qf",
		"query",
		"spectre_panel",
		"startuptime",
		"tsplayground",
		"neotest-output",
		"checkhealth",
		"neotest-summary",
		"neotest-output-panel",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- Fix conceallevel for json files
autocmd({ "FileType" }, {
	group = augroup("json_conceal"),
	pattern = { "json", "jsonc", "json5" },
	callback = function()
		vim.opt_local.conceallevel = 0
	end,
})

-- Cursor Line active only in current window
autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
	pattern = "*",
	command = "setlocal cursorline",
})
autocmd({ "WinLeave" }, {
	pattern = "*",
	command = "setlocal nocursorline",
})

-- Enable docker_compose_language_service LSP enforcing filetype
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#docker_compose_language_service
autocmd({ "FileType" }, {
	group = augroup("dockerChangeFt"),
	pattern = { "yaml" },
	callback = function(file)
		local names = { "compose.yaml", "compose.yml", "docker-compose.yaml", "docker-compose.yml" }
		for _, name in pairs(names) do
			if file.file == name then
				vim.bo.filetype = "yaml.docker-compose"
				break
			end
		end
	end,
})
