-- edit filesystem like a buffer

-- Declare a global function to retrieve the current directory
function _G.get_oil_winbar()
	local bufnr = vim.api.nvim_win_get_buf(vim.g.statusline_winid)
	local dir = require("oil").get_current_dir(bufnr)
	if dir then
		return vim.fn.fnamemodify(dir, ":~")
	else
		-- If there is no current directory (e.g. over ssh), just show the buffer name
		return vim.api.nvim_buf_get_name(0)
	end
end
return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	event = "VeryLazy",
	keys = { { "_", "<cmd>Oil --float<CR>", desc = "Open Oil" } },
	opts = {
		default_file_explorer = true,
		win_options = {
			winbar = "%!v:lua.get_oil_winbar()",
		},
		view_options = {
			show_hidden = true,
		},
		float = {
			max_width = 80,
			max_height = 15,
			border = "single",
			get_win_title = function()
				return ""
			end,
		},
		keymaps = {
			["gd"] = {
				desc = "Toggle file detail view",
				callback = function()
					detail = not detail
					if detail then
						require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
					else
						require("oil").set_columns({ "icon" })
					end
				end,
			},
		},
	},
}
