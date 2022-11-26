local g = vim.g

g.vimwiki_list = {{
	path = '~/wiki/',
	index = 'index',
	path_html = '/tmp/',
	diary_rel_path = '',
	diary_index = 'Journal',
	diary_header = 'Journal',
	syntax = 'markdown',
	ext = '.md',
	auto_generate_links = 1,
	auto_generate_tags = 1,
	auto_tags = 1,
	auto_diary_index = 1,
}}

-- treat every .md or .wiki file as a wiki
g.vimwiki_global_ext = 0
g.vimwiki_folding = 'list'

vim.cmd [[

function! VimwikiFindIncompleteTasks()
  lvimgrep /- \[ \]/ %:p
  lopen
endfunction

function! VimwikiFindAllIncompleteTasks()
  VimwikiSearch /- \[ \]/
  lopen
endfunction

]]
