local M = {}

M.kinds = function()
    local icons = {
        File = "󰈙 ",
        Module = " ",
        Namespace = "󰌗 ",
        Package = " ",
        Class = "󰌗 ",
        Method = "󰆧 ",
        Property = " ",
        Field = " ",
        Constructor = " ",
        Enum = "󰕘",
        Interface = "󰕘",
        Function = "󰊕 ",
        Variable = "󰆧 ",
        Constant = "󰏿 ",
        String = "󰀬 ",
        Number = "󰎠 ",
        Boolean = "◩ ",
        Array = "󰅪 ",
        Object = "󰅩 ",
        Key = "󰌋 ",
        Null = "󰟢 ",
        EnumMember = " ",
        Struct = "󰌗 ",
        Event = " ",
        Operator = "󰆕 ",
        TypeParameter = "󰊄 "
    }
    return icons
end

M.symbols = function()
    local icons = {
        ---Modification indicator.
        ---
        ---@type string
        modified = "●",

        ---Truncation indicator.
        ---
        ---@type string
        ellipsis = "…",

        ---Entry separator.
        ---
        ---@type string
        separator = "󰁕"
    }
    return icons
end

M.settings = function()
    local settings = {
        attach_navic = false -- prevent barbecue from automatically attaching nvim-navij
    }
    return settings
end

require("barbecue").setup({
    M.settings(),
    symbols = M.symbols(),
    kinds = M.kinds()
})
