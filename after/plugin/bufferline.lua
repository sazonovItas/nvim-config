local bufferline = require('bufferline')
bufferline.setup({
    options = {
        -- style_preset = bufferline.style_preset.no_italic,
        -- or you can combine these e.g.
        -- style_preset = {
        --    bufferline.style_preset.no_italic, bufferline.style_preset.no_bold
        -- }
        separator_style = "padded_slant",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = function(count, level, _, _)
            local icon = level:match("error") and " " or " "
            return " " .. icon .. count
        end
    }
})
