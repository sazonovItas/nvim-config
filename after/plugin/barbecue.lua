require("barbecue").setup({
    attach_navic = false, -- prevent barbecue from automatically attaching nvim-navij
    symbols = {
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
    },
    kinds = {
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
})
