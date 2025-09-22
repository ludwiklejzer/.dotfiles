-- Debugging
local function config()
	local dap = require("dap")
	local dapui = require("dapui")
	local dap_mason = require("mason-nvim-dap")

	dapui.setup()

	-- open ui automatically when attach dap
	dap.listeners.before.attach.dapui_config = function()
		dapui.open()
	end
	dap.listeners.before.launch.dapui_config = function()
		dapui.open()
	end

	-- set breakpoint symbols
	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticError" })
	vim.fn.sign_define("DapBreakpointCondition", { text = "ﳁ", texthl = "DapBreakpoint" })
	vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DiagnosticWarn" })
	vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DiagnosticInfo" })
	vim.fn.sign_define("DapStopped", { text = "", texthl = "DiagnosticHint" })

	-- set mason-nvim-dap config
	dap_mason.setup({
		-- ensure_installed = { "js", "python", "bash", "cppdbg", "node2" },
		automatic_installation = false,
		handlers = {},
	})

	-- dap adapters definition
	dap.adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "node",
			args = {
				vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
				"${port}",
			},
		},
	}

	dap.adapters.cppdbg = {
		id = "cppdbg",
		type = "executable",
		command = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
	}

	-- dap adapters configurations
	dap.configurations.c = {
		{
			name = "Launch file",
			type = "cppdbg",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopAtEntry = true,
		},
	}

	dap.configurations.typescript = {
		{
			name = "Lanunch Node",
			type = "node2",
			request = "launch",
			runtimeArgs = { "-r", "ts-node/register" },
			runtimeExecutable = "node",
			args = { "--inspect", "${file}" },
			skipFiles = { "node_modules/**" },
			console = "integratedTerminal",
		},
	}

	for _, language in ipairs({ "javascript", "javascriptreact" }) do
		dap.configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch (VSCode JS Debug)",
				program = "${file}",
				cwd = "${workspaceFolder}",
			},
			{
				name = "Launch (Node2)",
				type = "node2",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach (VSCode JS Debug)",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
			{
				name = "Attach (Node2)",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}
	end
end

return {
	"mfussenegger/nvim-dap",
	-- lazy = false,
	cmd = { "DapToggleBreakpoint", "DapContinue" },
	config = config,

	dependencies = {
		"rcarriga/nvim-dap-ui", -- Debugger UI
		"nvim-neotest/nvim-nio", -- Async IO library
		"jay-babu/mason-nvim-dap.nvim",
		"rcarriga/cmp-dap",
		{
			"LiadOz/nvim-dap-repl-highlights",
			config = function()
				require("nvim-dap-repl-highlights").setup()
			end,
		},
	},
}
