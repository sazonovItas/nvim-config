require("transparent").setup({
    groups = { -- table: default groups
        'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
        'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String',
        'Function', 'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr',
        'NonText', 'SignColumn', 'CursorLineNr', 'EndOfBuffer'
    },
    extra_groups = {
        "NormalFloat", -- pluginss which have float panel such as Lazy, Mason, LSPInfo
        "NeoTreeNormal", "NeoTreeBorder", "NeoTreeNormalNC", -- NeotTree windows
        "NeoTreeFloatBorder", "NeoTreeFloatTitle", -- NeoTree borders
        "TelescopeNormal", "TelescopeBorder" -- Telescope
    }, -- table: additional groups that should be cleared
    exclude_groups = {} -- table: groups you don't want to clear
})
