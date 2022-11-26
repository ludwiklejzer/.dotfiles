local function augroup(name, clear)
	vim.api.nvim_create_augroup(name, { clear = clear })
end

local function autocmd(event, group, pattern, cmd)
	vim.api.nvim_create_autocmd(event, {
		group = group,
		pattern = pattern,
		command = cmd,
	})
end

-- meaningful backup name
autocmd("BufWritePre", nil, "*", "let &bex = '@' . strftime(\"%F.%H:%M\")")

-- remove line numbers from terminal window and start in insert mode
autocmd("TermOpen", nil, "*", "setlocal nonumber norelativenumber | startinsert")

autocmd("BufLeave", nil, "term://*", "stopinsert")

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

-- hide cursor line in unfocused buffers
augroup("CursorLine", true)
autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, "CursorLine", "*", "setlocal cursorline")
autocmd("WinLeave", "CursorLine", "*", "setlocal nocursorline")
