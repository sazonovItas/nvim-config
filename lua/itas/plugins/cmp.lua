local cmp = require('cmp')

cmp.setup({
    snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end
    },
    mapping = {
        ["<C-c>"] = cmp.mapping.complete(),
        ["<C-y>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            else
                fallback()
            end
        end, {'i', 's'}),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            else
                fallback()
            end
        end, {"i", "s"})
    },
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered()
    },
    experimental = {native_menu = false, ghost_text = false},
    sources = cmp.config.sources({
        {name = 'nvim_lsp', max_item_count = 10},
        {name = 'luasnip', max_item_count = 10},
        {name = 'path', max_item_count = 10},
        {name = 'buffer', max_item_count = 10}
    })
})

local opts = {
    floating_window_off_x = 5, -- adjust float windows x position.
    floating_window_off_y = function() -- adjust float windows y position. e.g. set to -2 can make floating window move up 2 lines
        local linenr = vim.api.nvim_win_get_cursor(0)[1] -- buf line number
        local pumheight = vim.o.pumheight
        local winline = vim.fn.winline() -- line number in the window
        local winheight = vim.fn.winheight(0)

        -- window top
        if winline - 1 < pumheight then return pumheight end

        -- window bottom
        if winheight - winline < pumheight then return -pumheight end
        return 0
    end
}
require('lsp_signature').setup(opts)
