local utils = require("core.utils")

local map = utils.map
local cmd = vim.cmd

-- used to create personalized commands
local user_cmd = vim.api.nvim_create_user_command

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", "p:let @+=@0<CR>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- move cursor within insert mode
map("i", "<C-h>", "<Left>", { silent = true })
map("i", "<C-e>", "<End>", { silent = true })
map("i", "<C-l>", "<Right>", { silent = true })
map("i", "<C-j>", "<Down>", { silent = true })
map("i", "<C-k>", "<Up>", { silent = true })
map("i", "<C-a>", "<Home>", { silent = true })

-- resize window
map("n", "<UP>", ":resize -2<CR>", { silent = true })
map("n", "<DOWN>", ":resize +2<CR>", { silent = true })
map("n", "<LEFT>", ":vertical resize +2<CR>", { silent = true })
map("n", "<RIGHT>", ":vertical resize -2<CR>", { silent = true })

-- spelling
map("n", "<F8>", ':lua require("core.utils").setSpellLang("pt-BR")<CR>')
map("n", "<F7>", ':lua require("core.utils").setSpellLang("en-US")<CR>')
map("n", "z=", ":Telescope spell_suggest<CR>")
map("n", "^[", ":Telescope")

-- move lines
map("n", "<A-j>", ":m . +1<CR>==", { silent = true })
map("n", "<A-k>", ":m . -2<CR>==", { silent = true })
map("i", "<A-j>", "<Esc>:m . +1<CR>==gi", { silent = true })
map("i", "<A-k>", "<Esc>:m . -2<CR>==gi", { silent = true })
map("v", "<A-j>", ":m '>+1<CR>gv=gv", { silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv", { silent = true })

-- misc

map("t", "q", "<C-\\><C-n>:q!<CR>", { silent = true }) -- close terminal window
map("t", "X", "<C-\\><C-n>:bd!<CR>", { silent = true }) -- close terminal buffer
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true }) -- Go to normal mode on terminal
map("n", "<C-s>", "<cmd> :w <CR>") -- save buffer
map("i", "<C-s>", "<Esc>:w<CR>a") -- save buffer
map("n", '"', ":below 10sp term://zsh<CR>") -- open terminal
map("n", "q", ":quit<CR>", { silent = true }) -- quit window
map("n", "<S-q>", ":quitall!<CR>", { silent = true }) -- quit all windows without save
map("n", "<S-x>", ":bd<CR>", { silent = true }) -- unload buffer
map("n", "<C-j>", ":bn<CR>", { silent = true }) -- next buffer
map("n", "<C-k>", ":bp<CR>", { silent = true }) -- prev buffer
map("n", "<Esc>", "<cmd> :noh <CR>", { silent = true }) -- hide search highlighting
map("n", "<C-q>", "q", { silent = true }) -- record macro
map("i", "<C-o>", "<CR>", { silent = true }) -- fake enter

-------------
-- PLUGINS --
-------------

-- hop
map("n", "<Leader>h", ":HopChar1<CR>", { silent = true })

-- truezen
map("n", "<F9>", ":TZAtaraxis<CR>", { silent = true })

-- vimwiki
map("n", "<Leader>ww", ":VimwikiIndex<CR>", { silent = true })

-- nvim comment
map("n", "gcc", ":CommentToggle<CR>", { silent = true })
map("v", "gc", ":CommentToggle<CR>", { silent = true })

-- telescope
map("n", "<Leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { silent = true })
map("n", "<Leader>ff", ":Telescope find_files<CR>", { silent = true })
map(
	"n",
	"<Leader>f<Leader>f",
	':lua vim.fn.execute("Telescope find_files cwd=" .. vim.fn.expand("%:h"))<CR>',
	{ silent = true }
)
map("n", "<Leader>fc", ":Telescope find_files cwd=~/.config/nvim<CR>", { silent = true })
map(
	"n",
	"<Leader>fp",
	":lua require('telescope.builtin').find_files{cwd=require('telescope.utils').buffer_dir()}<CR>",
	{ silent = true }
)
map("n", "<Leader>fg", ":Telescope live_grep<CR>", { silent = true })
map(
	"n",
	"<Leader>f<Leader>g",
	':lua vim.fn.execute("Telescope live_grep cwd=" .. vim.fn.expand("%:h"))<CR>',
	{ silent = true }
)
map("n", "<Leader>cm", ":Telescope git_commits<CR>", { silent = true })
map("n", "<Leader>gst", ":Telescope git_status<CR>", { silent = true })
map("n", "<Leader>fh", ":Telescope help_tags<CR>", { silent = true })
map("n", "<Leader>fo", ":Telescope oldfiles<CR>", { silent = true })
map("n", "<Leader>th", ":Telescope themes<CR>", { silent = true })
map("n", "<leader>fa", "<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>", { silent = true })

-- nvim tree
map("n", "<C-b>", ":NvimTreeToggle<CR>", { silent = true })
map("n", "<C-A-b>", ":NvimTreeFindFile<CR>", { silent = true })

-- lsp
map("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
map("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
map("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
map("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
map("n", "<space>c", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
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
