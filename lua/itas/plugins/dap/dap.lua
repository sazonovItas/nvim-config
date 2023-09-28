-- debugging keymaps
local keymap = vim.keymap.set
keymap("n", "<leader>dc", function() require("dap").continue() end)
keymap("n", "<leader>do", function() require("dap").step_over() end)
keymap("n", "<leader>di", function() require("dap").step_into() end)
keymap("n", "<leader>db", function() require("dap").step_out() end)
keymap("n", "<leader>dt", function() require("dap").terminate() end)
keymap("n", "<F5>", function() require("dap").toggle_breakpoint() end)

local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] =
    function() dapui.open() end
dap.listeners.after.event_terminated["dapui_config"] =
    function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
