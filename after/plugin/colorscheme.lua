vim.cmd [[colorscheme tokyonight]]

local status, tokyonight = pcall(require, "tokyonight")
if not status then
    print("Tokyonight colorscheme isn't avaliable!")
    return
end

tokyonight.setup({style = "storm", transparent = true})

vim.fn.sign_define({
    {
        name = 'DiagnosticSignError',
        text = '',
        texthl = 'DiagnosticSignError',
        linehl = 'ErrorLine'
    }, {
        name = 'DiagnosticSignWarn',
        text = '',
        texthl = 'DiagnosticSignWarn',
        linehl = 'WarningLine'
    }, {
        name = 'DiagnosticSignInfo',
        text = '',
        texthl = 'DiagnosticSignInfo',
        linehl = 'InfoLine'
    }, {
        name = 'DiagnosticSignHint',
        text = '',
        texthl = 'DiagnosticSignHint',
        linehl = 'HintLine'
    }
})
