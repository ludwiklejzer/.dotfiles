local utils = require("core.utils")

local map = utils.map
local cmd = vim.cmd
local user_cmd = vim.api.nvim_create_user_command

-- Don't copy the replaced text after pasting in visual mode
map("v", "p", "p:let @+=@0<CR>")

-- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
map({ "n", "x", "o" }, "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
map({ "n", "x", "o" }, "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

-- move cursor within insert mode
map("i", "<C-h>", "<Left>")
map("i", "<C-e>", "<End>")
map("i", "<C-l>", "<Right>")
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-a>", "<Home>")

map("n", "<F5>", ":lua Compile()<CR>")

-- resize window
map("n", "<UP>", ":resize -2<CR>")
map("n", "<DOWN>", ":resize +2<CR>")
map("n", "<LEFT>", ":vertical resize +2<CR>")
map("n", "<RIGHT>", ":vertical resize -2<CR>")

map("n", "<S-t>", "<cmd> :enew <CR>") -- new buffer
map("n", "<C-s>", "<cmd> :w <CR>") -- save buffer
map("n", "<S-x>", ":bd<CR>") -- unload buffer
map("n", "<C-j>", ":BufferLineCycleNext<CR>") -- next buffer
map("n", "<C-j>", ":BufferLineCyclePrev<CR>") -- prev buffer
map("n", "q", ":quit<CR>") -- quit window
map("n", "<S-q>", ":quitall!<CR>") -- quit all windows
map("n", "<Leader>pc", ":PackerCompile<CR>") -- compile config file
map("n", "<Leader>pi", ":PackerInstall<CR>") -- install plugins
map("n", "<Esc>", "<cmd> :noh <CR>") -- hide search highlighting
map("n", "<C-q>", "q") -- record macro
map("i", "<C-o>", "<CR>") -- fake enter
map("i", "<C-A-o>", "<ESC>O") -- insert line above
map("i", "<C-p>", "<Nop>") -- remove completion popup
map("i", "<C-n>", "<Nop>") -- remove completion popup

-- spelling
map("n", "<F8>", ":set spell! spelllang=pt_br spellfile=~/.config/nvim/spell/pt.utf-8.add<CR><CR>")
map("n", "<F7>", ":set spell! spelllang=en_us spellfile=~/.config/nvim/spell/en.utf-8.add<CR><CR>")
map("n", "z=", ":Telescope spell_suggest<CR>")

-- Add Packer commands because we are not loading it at startup

local packer_cmd = function(callback)
	return function()
		require("plugins")
		require("packer")[callback]()
	end
end

user_cmd("PackerClean", packer_cmd("clean"), {})
user_cmd("PackerCompile", packer_cmd("compile"), {})
user_cmd("PackerInstall", packer_cmd("install"), {})
user_cmd("PackerStatus", packer_cmd("status"), {})
user_cmd("PackerSync", packer_cmd("sync"), {})
user_cmd("PackerUpdate", packer_cmd("update"), {})

-------------
-- PLUGINS --
-------------

-- hop
map("n", "<Leader>h", ":HopChar1<CR>")

-- truezen
map("n", "<F9>", ":TZAtaraxis<CR>")

-- vimwiki
map("n", "<Leader>ww", ":VimwikiIndex<CR>")

-- nvim comment
map("n", "gcc", ":CommentToggle<CR>")
map("v", "gc", ":CommentToggle<CR>")

-- telescope
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fp", ":lua require('telescope.builtin').find_files{cwd=require('telescope.utils').buffer_dir()}<CR>")

map("n", "<Leader>fg", ":Telescope live_grep<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>cm", ":Telescope git_commits<CR>")
map("n", "<Leader>gst", ":Telescope git_status<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>th", ":Telescope themes<CR>")
map("n", "<leader>fa", "<cmd> :Telescope find_files follow=true no_ignore=true hidden=true <CR>")

-- bufferline
map("n", "<C-j>", ":BufferLineCycleNext<CR>")
map("n", "<C-k>", ":BufferLineCyclePrev<CR>")

-- nvim tree
map("n", "<C-b>", ":NvimTreeToggle<CR>")
map("n", "<C-A-b>", ":NvimTreeFindFile<CR>")

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
