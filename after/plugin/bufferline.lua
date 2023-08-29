local M = {}

M.highlights = function()
    local theme = {
        buffer_selected = {bold = true},
        diagnostic_selected = {bold = true},
        info_selected = {bold = true},
        info_diagnostic_selected = {bold = true},
        warning_selected = {bold = true},
        warning_diagnostic_selected = {bold = true},
        error_selected = {bold = true},
        error_diagnostic_selected = {bold = true}
    }
    return theme
end

local bufferline = require('bufferline')
bufferline.setup({
    options = {
        highlights = M.highlights(),
        show_close_icon = true,
        diagnostics = "nvim_lsp",
        max_prefix_length = 10,
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end
    }
})
