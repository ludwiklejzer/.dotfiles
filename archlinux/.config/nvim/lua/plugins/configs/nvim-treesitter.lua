require('nvim-treesitter.configs').setup {
	context_commentstring = {
		enable = true,
	},
	indent = { enable = true },
	ensure_installed = {
		'lua',
		'html',
		'scss',
		'json',
		'css',
		'javascript',
		'tsx',
		'typescript',
		'bash',
		'python',
		'markdown',
		'yaml',
		'vue',
		'vim',
	},
	highlight = { enable = true, use_languagetree = true },
}
