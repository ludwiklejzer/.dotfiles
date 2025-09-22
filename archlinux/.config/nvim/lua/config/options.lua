local opt = vim.opt
local g = vim.g

g.mapleader = " "
g.maplocalleader = ","

vim.cmd("set modeline")
vim.cmd("language en_US.utf8")

vim.g.python3_host_prog = vim.fn.expand("/usr/bin/python3")

-- add support to autodetect hyprlang language
vim.filetype.add({
	pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
})

-- global options
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,terminal,resize,winpos"
opt.termguicolors = true
opt.modeline = true
opt.relativenumber = true
opt.number = true
opt.numberwidth = 3
opt.ruler = false
opt.confirm = true
opt.mouse = "a"
opt.expandtab = false
opt.shiftwidth = 0
opt.shiftround = true
opt.autoindent = true
opt.smartindent = true
opt.tabstop = 2
opt.undofile = true
opt.updatetime = 750
opt.timeoutlen = 1000
opt.wrap = true
opt.errorbells = false
opt.linebreak = false
opt.breakindent = true
opt.breakindentopt = "sbr"
opt.showbreak = "┆ "
opt.shortmess:append("sICScs")
opt.hidden = true
opt.inccommand = "split"
opt.incsearch = true
opt.conceallevel = 0
opt.concealcursor = "nc"
opt.cul = true
opt.cursorlineopt = "both"
opt.showmode = false
opt.cmdheight = 0
opt.history = 1000
vim.schedule(function()
	opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
end)
opt.ignorecase = true
opt.smartcase = true
opt.title = true
opt.path:append("**")
opt.mousemodel = "popup"
-- opt.list = true
opt.listchars:append("space:-,tab:»\\ ,trail:·,precedes:←,extends:→")
opt.fillchars = {
	foldopen = " ",
	foldclose = "",
	foldsep = " ",
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
opt.signcolumn = "yes:1"
opt.pumheight = 15
opt.splitbelow = true
opt.splitright = true
opt.whichwrap:append("<>[]hl")
opt.laststatus = 0
opt.showcmdloc = "statusline"
opt.backup = true
opt.backupskip:append("*.enc,*.pem,*.key,*.crt,*.cer,*.asc,*.aes,*.pgp,*.swp,*.tmp,*.log,*.bak,*.cache")
opt.backupdir = os.getenv("HOME") .. "/.local/state/nvim/backup/"
opt.writebackup = true
opt.backupcopy = "yes"
-- saved words
-- opt.spellfile = vim.fn.stdpath("config") .. "/spell/en.utf-8.add," .. vim.fn.stdpath("config") .. "/spell/pt.utf-8.add"
-- opt.spelllang = "en,pt"
opt.foldcolumn = "1"
opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
opt.foldenable = true
opt.foldlevelstart = 99
opt.foldtext = "v:lua.MyFoldText()"
opt.background = "dark"
opt.completeopt = "menu,menuone,noinsert,preview"

-- foldend, foldlevel, foldstart, folddashes

function MyFoldText()
	local foldstart = vim.fn.getline(vim.v.foldstart)

	-- remove the two spaces from the beginning of lines with more than 2 spaces
	if foldstart:sub(1, 2) == "  " then
		foldstart = foldstart:sub(3)
	end

	return " " .. foldstart .. " "
end

-- Neovide specific configs
if vim.g.neovide then
	vim.opt.linespace = 2

	vim.g.neovide_padding_top = 5
	vim.g.neovide_padding_bottom = 0
	vim.g.neovide_padding_right = 0
	vim.g.neovide_padding_left = 0
	vim.opt.termguicolors = true
	vim.g.neovide_transparency = 0.9
	vim.g.transparency = 0.9
	vim.g.neovide_floating_shadow = false
	vim.g.neovide_cursor_vfx_mode = "pixiedust"
	vim.g.neovide_cursor_vfx_particle_lifetime = 2.2
	vim.g.neovide_cursor_vfx_particle_density = 24.0

	-- Enable Ctrl + Shift + v to paste content
	vim.keymap.set({ "n", "v", "s", "x", "o", "i", "l", "c", "t" }, "<C-S-v>", function()
		vim.api.nvim_paste(vim.fn.getreg("+"), true, -1)
	end, { noremap = true, silent = true })
end
