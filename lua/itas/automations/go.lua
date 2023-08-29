local ts_utils = require("nvim-treesitter.ts_utils")
local function get_struct_name()
    local node = ts_utils.get_node_at_cursor(winnr, ignore_injected_langs)
end
