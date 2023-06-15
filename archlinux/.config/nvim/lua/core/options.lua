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
opt.wrap = false -- break line or not
opt.breakindent = true -- indent broken line
opt.shortmess:append("c") -- avoid hit enter prompts
opt.shortmess:append("sI") -- disable nvim intro
opt.hidden = true -- allow edit buffer without save
opt.inccommand = "split" -- command live preview
opt.cul = false -- highlight the line of the cursor
opt.showmode = false -- hide status mode
opt.cmdheight = 0 -- command line height
opt.clipboard = "unnamedplus" -- sync clipboard between OS and Neovim
opt.ignorecase = true -- search case insensitive
opt.smartcase = true -- override ignorecase
opt.title = true -- show filename in the title bar
opt.path:append("**") -- recursive find
opt.mousemodel = "popup" -- open popup with the right mouse button
opt.fillchars = { fold = "─" } -- change folding symbol
opt.fillchars = { eob = " " } -- hide empty lines tilde
opt.signcolumn = "auto:1" -- show only when there is a sign to show
opt.pumheight = 15 -- maximum number of items in the popup menu
opt.splitbelow = true -- put new windows below
opt.splitright = true -- put new windows right
opt.whichwrap:append("<>[]hl") -- go to next or previous line
opt.laststatus = 0 -- statusbar
opt.backup = true -- life saver
opt.backupskip:append("*.asc,*.aes,*.pgp") -- skip these filetypes on backup
opt.spellfile = vim.fn.stdpath("config") .. "/spell/words.utf-8.add" -- saved words
opt.backupdir = "/home/ludwiklejzer/.config/nvim/backup/" -- backups oath
opt.writebackup = true -- backup before overwriting the current buffer
opt.backupcopy = "yes" -- overwrite the original backup file
opt.foldmethod = "expr" -- folding based on expression
opt.foldexpr = "nvim_treesitter#foldexpr()" -- expression used on folding
opt.foldenable = true -- folding on VimEnter
opt.foldlevelstart = 99 -- disable auto folding everything
opt.foldtext = "v:lua.MyFoldText()" -- custom folding function

function MyFoldText()
	local line = vim.fn.getline(vim.v.foldstart)
	return line .. " "
end
