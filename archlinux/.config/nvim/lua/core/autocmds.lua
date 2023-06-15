local utils = require("core.utils")

local autocmd = utils.autocmd
local augroup = utils.augroup

-- encrypted files
augroup("OpenSSL", true)
autocmd("BufReadPost", "OpenSSL", "*.aes", ":lua OpenSsl.decrypt()")
autocmd("BufWritePost", "OpenSSL", "*.aes", ":lua OpenSsl.save()")
autocmd("BufUnload", "OpenSSL", "*.aes", ":lua OpenSsl.exit()")
autocmd("BufEnter", "OpenSSL", "*.aes", ":setlocal noundofile shada=")

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
