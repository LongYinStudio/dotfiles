local vfn = vim.fn
local api = vim.api

return {
	"mfussenegger/nvim-dap",
	cond = true,
	config = function()
		---@param mode string|string[]
		---@param keys string
		---@param func string|function
		---@param desc string
		local keymap = function(mode, keys, func, desc)
			if desc then
				desc = "" .. desc
			end
			vim.keymap.set(mode, keys, func, { noremap = true, silent = true, desc = desc })
		end

		local dap, widgets = require("dap"), require("dap.ui.widgets")

		-- 对各个语言的配置
		-- require("plugins.dap.lang-conf.node")
		require("plugins.dap.lang-conf.web")
		require("plugins.dap.lang-conf.codelldb") -- c/c++
		require("plugins.dap.lang-conf.python") -- 使用的mason 安装的 debugpy , venv里安装的也行, 当然全局安装的也行

		vim.api.nvim_create_user_command("InstallAllDap", function()
			local packages = { "js-debug-adapter", "codelldb", "debugpy" }
			vim.cmd("MasonInstall " .. table.concat(packages, " "))
		end, {})

		vfn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		vfn.sign_define("DapBreakpointCondition", { text = " ", texthl = "", linehl = "", numhl = "" }) --   🐛
		vfn.sign_define("DapLogPoint", { text = " ", texthl = "", linehl = "", numhl = "" }) -- 󰍩 🇱
		vfn.sign_define("DapStopped", { text = "👉", texthl = "", linehl = "", numhl = "" }) -- ⭐️
		vfn.sign_define("DapBreakpointRejected", { text = " ", texthl = "", linehl = "", numhl = "" }) -- ✋ ⚠️

		---@param config {type?:string, args?:string[]|fun():string[]?}
		local function get_args(config)
			local args = type(config.args) == "function" and (config.args() or {}) or config.args or {} --[[@as string[] | string ]]
			local args_str = type(args) == "table" and table.concat(args, " ") or args --[[@as string]]

			config = vim.deepcopy(config)
			---@cast args string[]
			config.args = function()
				local new_args = vim.fn.expand(vim.fn.input("Run with args: ", args_str)) --[[@as string]]
				if config.type and config.type == "java" then
					---@diagnostic disable-next-line: return-type-mismatch
					return new_args
				end
				return require("dap.utils").splitstr(new_args)
			end
			return config
		end

		keymap({ "n", "i", "t" }, "<F1>", dap.continue, "Continue")
		keymap({ "n", "i", "t" }, "<F2>", dap.step_over, "Step Over")
		keymap({ "n", "i", "t" }, "<F3>", dap.step_into, "Step Info")
		keymap({ "n", "i", "t" }, "<F4>", dap.step_out, "Step Out")
		keymap({ "n", "i", "t" }, "<F5>", dap.step_back, "Step Back")
		keymap({ "n", "i", "t" }, "<F6>", dap.run_last, "Run Last")
		keymap({ "n", "i", "t" }, "<F7>", dap.terminate, "Terminate")
		keymap({ "n", "i", "t" }, "<F8>", dap.pause, "Pause")
		keymap({ "n", "i", "t" }, "<F9>", dap.disconnect, "Disconnect")
		-- keymap("n", "<leader>dB", function()
		-- 	dap.set_breakpoint(vfn.input("Condition: "), vfn.input("Hit condition: "), vfn.input("Log message: "))
		-- end)
		-- keymap("n", "<leader>dp", function()
		-- 	dap.set_breakpoint(nil, nil, vfn.input("Log point message: "))
		-- end)
		keymap("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, "Breakpoint Condition")
		keymap("n", "<leader>db", function()
			dap.toggle_breakpoint()
		end, "Toggle Breakpoint")
		keymap("n", "<leader>dc", function()
			dap.continue()
		end, "Run/Continue")
		keymap("n", "<leader>da", function()
			dap.continue({ before = get_args })
		end, "Run with Args")
		keymap("n", "<leader>dC", function()
			dap.run_to_cursor()
		end, "Run to Cursor")
		keymap("n", "<leader>dg", function()
			dap.goto_()
		end, "Go to Line (No Execute)")
		keymap("n", "<leader>di", function()
			dap.step_into()
		end, "Step Into")
		keymap("n", "<leader>dj", function()
			dap.down()
		end, "Down")
		keymap("n", "<leader>dk", function()
			dap.up()
		end, "Up")
		keymap("n", "<leader>dl", function()
			dap.run_last()
		end, "Run Last")
		keymap("n", "<leader>do", function()
			dap.step_out()
		end, "Step Out")
		keymap("n", "<leader>dO", function()
			dap.step_over()
		end, "Step Over")
		keymap("n", "<leader>dP", function()
			dap.pause()
		end, "Pause")
		keymap("n", "<leader>dr", function()
			dap.repl.toggle()
			-- dap.repl.open
		end, "Toggle REPL")
		keymap("n", "<leader>ds", function()
			dap.session()
			-- widgets.centered_float(widgets.sessions)
		end, "Session")
		keymap("n", "<leader>dt", function()
			dap.terminate()
		end, "Terminate")
		keymap("n", "<leader>dw", function()
			widgets.hover()
		end, "Widgets Hover")
		keymap("n", "<leader>dD", function()
			dap.close()
		end, "Clear Breakpoints")

		-- keymap("n", "<leader>dq", function() dap.close() end, "Close Session")
		-- keymap("n", "<leader>dr", function() dap.restart_frame() end, "Restart")

		-- keymap("n", "<Leader>df", function()
		-- 	widgets.centered_float(widgets.frames)
		-- end)
		-- keymap("n", "<Leader>ds", function()
		-- 	widgets.centered_float(widgets.scopes)
		-- end)
		-- keymap("n", "<Leader>dx", function()
		-- 	widgets.centered_float(widgets.threads)
		-- end)

		local pbp = require("persistent-breakpoints.api")

		pbp.load_breakpoints()

		-- 自动开启ui
		dap.listeners.after.event_initialized["dapui_config"] = function()
			local dapui = require("dapui")
			dapui.open()
			api.nvim_command("DapVirtualTextEnable")
			_G.dapui_for_K = true
		end

		dap.listeners.before.event_terminated["dapui_config"] = function()
			api.nvim_command("DapVirtualTextEnable")
			pbp.store_breakpoints()
			_G.dapui_for_K = false
		end
		dap.listeners.before.event_exited["dapui_config"] = function()
			api.nvim_command("DapVirtualTextEnable")
			pbp.store_breakpoints()
			_G.dapui_for_K = false
		end
		dap.listeners.before.disconnect["dapui_config"] = function()
			api.nvim_command("DapVirtualTextEnable")
			pbp.store_breakpoints()
			_G.dapui_for_K = false
		end

		dap.defaults.fallback.focus_terminal = false
		dap.defaults.fallback.force_external_terminal = false
	end,
}
