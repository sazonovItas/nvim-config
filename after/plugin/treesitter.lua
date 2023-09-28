local M = {}

M.code_highlight = function()
    local installed = {
        "bash", "c", "m68k", "html", "javascript", "json", "lua", "luadoc",
        "luap", "markdown", "markdown_inline", "python", "query", "regex",
        "tsx", "typescript", "vim", "vimdoc", "yaml", "go", "cmake"
    }
    return installed
end

M.config = function()
    local opts = {
        -- Add a language of your choice
        ensure_installed = M.code_highlight(),
        sync_install = false,
        ignore_install = {""}, -- List of parsers to ignore installing
        highlight = {
            enable = true, -- false will disable the whole extension
            disable = {""}, -- list of language that will be disabled
            additional_vim_regex_highlighting = true

        },
        indent = {enable = true, disable = {"yaml"}},
        rainbow = {
            enable = true,
            -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
            extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
            max_file_lines = 10000 -- Do not enable for files with more than n lines, int
            -- colors = {}, -- table of hex strings
            -- termcolors = {} -- table of colour name strings
        }
    }
    return opts
end

local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
    print("Treesitter isn't working")
    return
end

treesitter.setup(M.config())
