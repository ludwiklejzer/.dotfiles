local utils = require("core.utils")

local map = utils.map
local cmd = vim.cmd

map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- used to create personalized commands
local user_cmd = vim.api.nvim_create_user_command

-- go to the next/prev element in quickfix
map("n", "<C-n>", ":if !empty(getqflist()) | cn | endif<CR>")
map("n", "<C-p>", ":if !empty(getqflist()) | cp | endif<CR>")

-- compiling
map("n", "<F5>", ":silent make run <bar> copen<CR>")
map("n", "<F4>", ":silent make <bar> copen<CR>")
map("n", "<F3>", ":make clean<CR>")
map("n", "<F2>", ":below 10sp term://make run<CR>i")

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", "p:let @+=@0<CR>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- remove tab spaces
map("i", "<S-Tab>", "<C-d>")

-- add a semicolon to the end of a line
-- map("i", "<A-l>", "<Esc>A;")
-- map("n", "<A-l>", "A;<Esc>")

-- Swap mark jump types ` and '
map("n", "`", "'")
map("n", "'", "`")

-- resize window
map("n", "<UP>", ":resize -2<CR>")
map("n", "<DOWN>", ":resize +2<CR>")
map("n", "<LEFT>", ":vertical resize +2<CR>")
map("n", "<RIGHT>", ":vertical resize -2<CR>")

-- spelling
map("n", "z=", ":Telescope spell_suggest<CR>")
map("n", "^[", ":Telescope")

-- move lines
map("n", "<A-j>", ":m . +1<CR>==")
map("n", "<A-k>", ":m . -2<CR>==")
map("v", "<A-j>", ":m '>+1<CR>gv=gv")
map("v", "<A-k>", ":m '<-2<CR>gv=gv")

-- indent without deselecting in visual mode
map("v", "<", "<gv")
map("v", ">", ">gv")

-- terminal
map(
	{ "n", "t" },
	"<C-'>",
	"<cmd>lua if vim.bo.buftype == 'terminal' then vim.cmd(':q!') else vim.cmd(':belowright 10sp term://zsh') end<CR>",
	{ desc = "open terminal" }
) --
map("t", "<ESC><ESC>", "<C-\\><C-n>", { desc = "Go to normal mode on terminal" }) --
map("t", "<C-w>k", "<cmd>wincmd k<cr>", { desc = "Go to Upper Window" })
map("t", "<C-w>l", "<cmd>wincmd l<cr>", { desc = "Go to Right Window" })
map("t", "<C-w>j", "<cmd>wincmd j<cr>", { desc = "Go to Lower Window" })
map("t", "<C-w>h", "<cmd>wincmd h<cr>", { desc = "Go to Left Window" })

-- misc
map("n", "<Leader>sw", ":set wrap!<CR>") -- toggle wrap
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save Buffer" })
map("n", "q", ":quit<CR>") -- quit window
map("n", "<S-q>", ":quitall!<CR>") -- quit all windows without save
map("n", "<S-x>", ":bp<bar>sp<bar>bn<bar>bd<CR>") -- unload buffer without closing window
map("n", "<C-j>", ":bn<CR>") -- next buffer
map("n", "<C-k>", ":bp<CR>") -- prev buffer
map("n", "<Esc>", "<cmd> :noh <CR>") -- hide search highlighting
map("n", "<C-q>", "q") -- record macro

-------------
-- PLUGINS --
-------------

-- hop
map("n", "<Leader>h", ":HopChar1<CR>")

-- Neorg
map("n", "<Leader>ww", ":Neorg index<CR>")

-- telescope
map("n", "<Leader>ff", ":Telescope find_files hidden=true preview_title= prompt_title=<CR>")
map(
	"n",
	"<Leader>f<Leader>f",
	[[:lua require'telescope.builtin'.find_files({ cwd = vim.fn.expand("%:p:h"), preview_title="", prompt_title="" })<CR>]]
)
map("n", "<Leader>fc", ":Telescope find_files cwd=$HOME/.config/nvim/lua preview_title= prompt_title=<CR>")
map(
	"n",
	"<Leader>fp",
	":lua require('telescope.builtin').find_files{cwd=require('telescope.utils').buffer_dir(),  preview_title='', prompt_title=''}<CR>"
)
map("n", "<Leader>fg", ":Telescope live_grep<CR>")
map("n", "<Leader>f<Leader>g", ':lua vim.fn.execute("Telescope live_grep cwd=" .. vim.fn.expand("%:h"))<CR>')
map("n", "<Leader>cm", ":Telescope git_commits<CR>")
map("n", "<Leader>gst", ":Telescope git_status<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>th", ":Telescope themes<CR>")
map("n", "<leader>fa", "<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>")
map("n", "<Leader>ft", ":Telescope<CR>")
map("n", "<Leader>fr", ":Telescope resume<CR>")
map("n", "<Leader>cc", ":Telescope colorscheme<CR>")

-- lsp
map("n", "<Leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "<Leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "<Leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "<Leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<Leader>c", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
map("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
map("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
map("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
map("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
map("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
map("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
map("n", "<space>f", "<cmd>lua vim.lsp.buf.format()<CR>")
map("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>")
map("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>")
map("n", "<space>q", "<cmd>lua vim.diagnostic.setloclist()<CR>")
map(
	"n",
	"<space>ih",
	"<cmd>lua vim.lsp.inlay_hint.enable(0, not vim.lsp.inlay_hint.is_enabled())<CR>:hi LspInlayHint guibg=#333333<CR>"
)

-- nvim-dap
map("n", "<leader>du", ':lua require("dapui").toggle()<CR>')
map("n", "<leader>db", ":DapToggleBreakpoint<CR>")
map("n", "<leader>dc", ":DapContinue<CR>")
map("n", "<leader>dt", ":DapTerminate<CR>")
map("n", "<leader>dr", ":lua require('dapui').open({reset = true})<CR>")
map("n", "<F9>", ":DapStepOver<CR>")
map("n", "<F10>", ":DapStepInto<CR>")
map("n", "<F11>", ":DapStepOut<CR>")
