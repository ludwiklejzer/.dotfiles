local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

vim.cmd("set modeline")

-- global options
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal,resize,winpos"
opt.termguicolors = true -- true colors support
opt.modeline = true
opt.relativenumber = true -- relative line numbers
opt.number = true -- current line number
opt.numberwidth = 3 -- minimal line number columns
opt.ruler = false -- hide line & column of the cursor
opt.confirm = true -- confirm quit without save
opt.mouse = "a" -- mouse support
opt.expandtab = false -- indent with spaces
opt.shiftwidth = 0 -- number of indent space
opt.shiftround = true -- round indent
opt.autoindent = true -- auto indent new lines
opt.smartindent = true -- indent after {, before } and after 'cinwords'
opt.tabstop = 2 -- number of indent tab
opt.undofile = true -- keep a permanet undo file
opt.updatetime = 750 -- interval for writing swap file
opt.timeoutlen = 1000 -- time to wait for a mapping
opt.wrap = false -- break line or not
opt.errorbells = false -- disable error bell sound
opt.breakindent = true -- broken indent line
opt.breakindentopt = "sbr" -- broken indent line options
opt.showbreak = "┆ " -- broken indent line icon
opt.shortmess:append("sICScs") -- reduce cmdline messages
opt.hidden = true -- allow edit buffer without save
opt.inccommand = "split" -- command live preview
opt.incsearch = true -- highlight while searching with / or ?
opt.conceallevel = 2 -- conceal is almost completely hidden
opt.concealcursor = "nc" -- conceal in Normal and Command modes
opt.cul = true -- highlight the line of the cursor
opt.cursorlineopt = "both" -- highlight the line and number
opt.showmode = false -- hide status mode
opt.cmdheight = 0 -- command line height
opt.history = 1000 -- history size
vim.schedule(function()
	opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus" -- Sync with system clipboard
end)
opt.ignorecase = true -- search case insensitive
opt.smartcase = true -- override ignorecase
opt.title = true -- show filename in the title bar
opt.path:append("**") -- recursive find
opt.mousemodel = "popup"
opt.fillchars = {
	fold = "·",
	eob = " ",
	-- hide separator lines
	horiz = " ",
	horizdown = " ",
	horizup = " ",
	vert = " ",
	verthoriz = " ",
	vertleft = " ",
	vertright = " ",
	diff = "╱",
}
if vim.fn.executable("rg") ~= 0 then
	opt.grepprg = "rg --vimgrep"
end
opt.grepformat = "%f:%l:%c:%m"
opt.signcolumn = "auto:1" -- show only when there is a sign to show
opt.pumheight = 15 -- maximum number of items in the popup menu
opt.splitbelow = true -- put new windows below
opt.splitright = true -- put new windows right
opt.whichwrap:append("<>[]hl") -- go to next or previous line
opt.laststatus = 0 -- statusbar
opt.showcmdloc = "statusline" -- show partial cmd typed in statusbar
opt.backup = true -- life saver
opt.backupskip:append("*.asc,*.aes,*.pgp") -- skip these filetypes on backup
opt.backupdir = "/home/ludwiklejzer/.local/state/nvim/backup/" -- backup path
opt.writebackup = true -- backup before overwriting the current buffer
opt.backupcopy = "yes" -- overwrite the original backup file
-- saved words
-- opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add," .. vim.fn.stdpath("config") .. "/spell/pt.utf-8.add"
-- opt.spelllang = "en,pt"
opt.foldmethod = "expr" -- folding based on expression
opt.foldexpr = "nvim_treesitter#foldexpr()" -- expression used on folding
opt.foldenable = true -- folding on VimEnter
opt.foldlevelstart = 99 -- disable auto folding everything
opt.foldtext = "v:lua.MyFoldText()" -- custom folding function
opt.background = "dark"
opt.completeopt = "menu,menuone,noinsert,preview"

function MyFoldText()
	local line = vim.fn.getline(vim.v.foldstart)
	return line .. "  "
end
