local opt = vim.opt
local g = vim.g

g.mapleader = " "

-- global options
opt.termguicolors = true -- true colors support
opt.relativenumber = true -- relative line numbers
opt.number = true -- current line number
opt.numberwidth = 3 -- minimal line number columns
opt.ruler = false -- hide line & column of the cursor
opt.confirm = true -- confirm quit without save
opt.mouse = "a" -- mouse support
opt.expandtab = false -- indent with spaces
opt.shiftwidth = 0 -- number of indent space
opt.autoindent = true -- auto indent new lines
opt.tabstop = 2 -- number of indent tab
opt.undofile = true -- keep a permanet undo file
opt.updatetime = 750 -- interval for writing swap file
opt.timeoutlen = 1000 -- time to wait for a mapping
opt.shortmess:append("c") -- avoid hit enter prompts
opt.shortmess:append("sI") -- disable nvim intro
opt.hidden = true -- allow edit buffer without save
opt.inccommand = "split" -- command live preview
opt.cul = true -- cursor line
opt.showmode = false -- hide status mode
opt.cmdheight = 1 -- command line height
opt.clipboard:append("unnamedplus") -- clipboard method
opt.ignorecase = true -- searchs case insensitive
opt.smartcase = true -- override ignorecase
opt.title = true -- title of the window
opt.path:append("**") -- recursive find
opt.mousemodel = "popup" -- right mouse button
opt.fillchars = { eob = " ", fold = "─" } -- disable tilde & change folding symbol
opt.signcolumn = "auto:1" -- only when there is a sign to show
opt.pumheight = 15 -- popup menu size
opt.splitbelow = true -- put new windows below
opt.splitright = true -- put new windows right
opt.whichwrap:append("<>[]hl") -- go to next or previous line
opt.laststatus = 3 -- global statusbar
opt.backup = true -- life saver
opt.backupdir = "/home/ludwiklejzer/.config/nvim/backup/" -- backups oath
opt.writebackup = true -- make backup before overwriting the current buffer
opt.backupcopy = "yes" -- overwrite the original backup file
opt.foldmethod = "expr" -- folding based on expression
opt.foldexpr = "nvim_treesitter#foldexpr()" -- expression used on folding
opt.foldenable = false -- disable folding on vimenter
opt.foldlevelstart = 99 -- disable auto folding everything
opt.foldtext = "v:lua.MyFoldText()"

function MyFoldText()
	local line = vim.fn.getline(vim.v.foldstart)
	local line_count = vim.v.foldend - vim.v.foldstart + 1
	-- return '├── ' .. line_count .. ' lines: ' .. line
	return "├──  " .. line .. " "
end

-- disable some builtin vim plugins
local default_plugins = {
	"2html_plugin",
	"getscript",
	"getscriptPlugin",
	"gzip",
	"logipat",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"matchit",
	"tar",
	"tarPlugin",
	"tohtml",
	"rrhelper",
	"vimball",
	"vimballPlugin",
	"zip",
	"zipPlugin",
}

for _, plugin in pairs(default_plugins) do
	g["loaded_" .. plugin] = 1
end
