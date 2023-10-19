local utils = require("core.utils")

local autocmd = utils.autocmd
local augroup = utils.augroup

-- highlight cul number
autocmd("BufEnter", nil, "*", ":hi CursorLineNr guibg=#E7ECF0")

-- set line wrap and line break on md and txt files
autocmd("FileType", nil, "markdown,text,json", ":set linebreak wrap")

-- encrypted files
augroup("OpenSSL", true)
autocmd({ "BufReadPre", "FileReadPre" }, "OpenSSL", "*.aes", "lua require('cmp').setup.buffer({ sources = {} })")
autocmd({ "BufReadPre", "FileReadPre" }, "OpenSSL", "*.aes", ":setlocal noswapfile noundofile nobackup binary shada=")
autocmd({ "BufReadPost", "FileReadPost" }, "OpenSSL", "*.aes", ":lua OpenSsl.open()")
autocmd({ "BufWritePre", "FileWritePre" }, "OpenSSL", "*.aes", ":lua OpenSsl.save()")
autocmd({ "BufReadPost", "FileReadPost" }, "OpenSSL", "*.aes", ":setlocal nobinary")
autocmd({ "BufWritePost", "FileWritePost" }, "OpenSSL", "*.aes", ":silent undo")

-- set vimwiki folding method to `syntax` because treesitter
-- `expr` does not support folding headers
autocmd("FileType", nil, "vimwiki", ":setlocal foldmethod=syntax")

-- persistent folding
augroup("AutoSaveFolds", true)
autocmd("BufWinLeave", "AutoSaveFolds", "*", "if mode() !=# 'i' && expand('%:t') != '' |  silent! mkview | endif")
autocmd("BufWinEnter", "AutoSaveFolds", "*", "if mode() !=# 'i' && expand('%:t') != ''  | silent! loadview | endif")

-- meaningful backup name
autocmd("BufWritePre", nil, "*", "let &bex = '@' . strftime(\"%F.%H:%M\")")

-- remove line numbers from terminal window and start in insert mode
autocmd("TermOpen", nil, "*", "setlocal nonumber norelativenumber | startinsert")

-- Open a file from its last left off position
autocmd(
	"BufReadPost",
	nil,
	"*",
	"autocmd FileType <buffer> ++once "
		.. "if &ft !~# 'commit\\|rebase' && "
		.. 'line("\'\\"") > 1 && '
		.. 'line("\'\\"") <= line("$") | exe \'normal! g`"\' | endif'
)

-- Close nvim-tree when it is the last window
autocmd("BufEnter", nil, "*", "if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif")

autocmd(
	"ColorScheme",
	nil,
	"*",
	":lua if vim.g.colors_name ~= 'wally' then require('lualine').setup({options = {theme = 'auto'}}) else require('lualine').setup({options = {theme = 'auto'}}) end"
)

-- refresh lualine when resizing
autocmd("VimResized", nil, "*", ":lua require('lualine').refresh()")
