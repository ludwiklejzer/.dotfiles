local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name, clear)
	return vim.api.nvim_create_augroup(name, { clear = clear })
end

-- persistent folding
autocmd({ "BufWInEnter" }, {
	group = augroup("AutoLoadFolding"),
	pattern = "*",
	callback = function(args)
		local filetype = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
		local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })
		local ignore_filetypes = { "gitcommit", "gitrebase", "svg", "hgcommit" }
		if buftype == "" and filetype and filetype ~= "" and not vim.tbl_contains(ignore_filetypes, filetype) then
			vim.b[args.buf].view_activated = true
			vim.cmd.loadview({ mods = { emsg_silent = true } })
		end
	end,
})

autocmd({ "BufWinLeave" }, {
	group = augroup("AutoSaveFolding"),
	pattern = "*",
	callback = function(args)
		if vim.b[args.buf].view_activated then
			vim.cmd.mkview({ mods = { emsg_silent = true } })
		end
	end,
})

-- Lazy loaded autocmds
autocmd("User", {
	pattern = "VeryLazy",
	callback = function()
		-- Attach lsp inside other filetypes
		autocmd("InsertEnter", {
			once = true,
			pattern = { "*.html", "*.md" },
			callback = function()
				require("otter").activate()
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
				-- vim.opt_local.buflisted = false -- remove from buffer cycly list
				vim.cmd("startinsert")
			end,
		})

		-- enter terminal windows in insert mode
		autocmd({ "WinEnter" }, {
			group = nil,
			pattern = { "term://*" },
			callback = function()
				vim.cmd("startinsert")
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

		-- Create missing parent directories when saving a file
		vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre" }, {
			group = vim.api.nvim_create_augroup("auto_create_dir", { clear = true }),
			callback = function(event)
				if event.match:match("^%w%w+://") then
					return
				end
				local file = vim.loop.fs_realpath(event.match) or event.match
				vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
			end,
		})
	end,
})
