call plug#begin()
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
call plug#end()

filetype plugin indent on
syntax on
setlocal path+=**
set cot=menu,menuone
set laststatus=0
set termguicolors
set nu
set relativenumber
set numberwidth=3
" set ruler!
set autoindent
set confirm
set mouse=a
set undofile
set shiftwidth=0
set softtabstop=0
set tabstop=2
set shortmess+=caFsI
set hidden
set inccommand=split
set incsearch
" set showmode!
set cmdheight=1
set clipboard+=unnamedplus
set ignorecase
set smartcase
set fillchars=eob:\ ,fold:─,vert:·
hi VertSplit guibg=NONE guifg=green gui=NONE
set signcolumn=auto
set pumheight=15
set splitbelow
set splitright
set whichwrap+=<>[]hl
set foldmethod=indent
" set foldexpr = ''
set foldenable
set foldlevelstart=99
set foldtext=CustomFold()

function! CustomFold()
	return printf('├──  %s ', getline(v:foldstart))
endfunction


" Mappings
let mapleader="\<Space>" 

nnoremap <leader>sl :source ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :e ~/.config/nvim/init.vim<CR>
nnoremap <C-s> :write<CR>
nnoremap q :quit<CR>
nnoremap Q :quitall<CR>
nnoremap <C-q> :quitall!<CR>
nnoremap <silent> <ESC> :noh<CR>
nnoremap <silent> <S-x> :bd<CR>
nnoremap <silent> <S-t> :enew<CR>
nnoremap <silent> <C-j> :bn<CR>
nnoremap <silent> <C-k> :bp<CR>
nnoremap <UP> :resize -2<CR>
nnoremap <DOWN> :resize +2<CR>
nnoremap <LEFT> :vertical resize +2<CR>
nnoremap <RIGHT> :vertical resize -2<CR>
noremap Y y$
nnoremap <Leader>cw :%s/\<<C-r><C-w>\>/<C-r><C-w>
nnoremap <leader>cc :execute "set colorcolumn=" . (&colorcolumn == "" ? "80" : "")<CR>

inoremap <C-s> <ESC>:write<CR>a
inoremap <C-e> <C-o>$

vnoremap <Leader>cw y:%s/<C-r>"/<C-r>"
vnoremap < <gv
vnoremap > >gv


" Colors
hi Normal ctermbg=NONE guibg=NONE
hi Visual ctermfg=0 guifg=black

hi GitGutterAddInvisible ctermbg=NONE guibg=NONE
hi GitGutterChangeInvisible ctermbg=NONE guibg=NONE
hi GitGutterDeleteInvisible ctermbg=NONE guibg=NONE
hi GitGutterChangeDeleteInvisible ctermbg=NONE guibg=NONE
hi GitGutterAdd ctermbg=NONE guibg=NONE
hi GitGutterChange ctermbg=NONE guibg=NONE guifg=magenta
hi GitGutterDelete ctermbg=NONE guibg=NONE guifg=red
hi GitGutterChangeDelete ctermbg=NONE guibg=NONE guifg=red

hi Folded guibg=NONE
hi FoldColumn guibg=NONE
hi SignColumn guibg=NONE

hi Pmenu guibg=NONE guifg=white
hi PmenuSel guifg=black
hi PmenuSbar guibg=NONE

hi TabLine guibg=NONE
hi TabLineFill guibg=NONE


" Autocomplete
ino <BS> <BS><C-r>=getline('.')[col('.')-3:col('.')-2]=~#'\k\k'?!pumvisible()?"\<lt>C-n>\<lt>C-p>":'':pumvisible()?"\<lt>C-y>":''<CR>
ino <CR> <C-r>=pumvisible()?"\<lt>C-y>":""<CR><CR>
ino <Tab> <C-r>=pumvisible()?"\<lt>C-n>":"\<lt>Tab>"<CR>
ino <S-Tab> <C-r>=pumvisible()?"\<lt>C-p>":"\<lt>S-Tab>"<CR>

augroup MyAutoComplete 
	au!
	au InsertCharPre * if
		\ !exists('s:complete') &&
		\ !pumvisible() &&
		\ getline('.')[col('.')-2].v:char =~# '\k\k' |
			\ let s:complete = 1 |
			\ noautocmd call feedkeys("\<C-n>\<C-p>", "nt") |
		\ endif
	au CompleteDone * if exists('s:complete') | unlet s:complete | endif
augroup END


" Plugins disabled
let g:loaded_2html_plugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_matchit = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_rrhelper = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
