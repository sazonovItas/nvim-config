-- lazy.nvim bootstrap
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
        lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- include custom options and keymap
require("itas.core.options")
require("itas.core.keymaps")

local status, configLazy = pcall(require, "lazy")
if not status then return end

configLazy.setup({

    -- Colorscheme https://github.com/folke/tokyonight.nvim
    {"folke/tokyonight.nvim", lazy = false, priority = 1000},

    -- Transparent https://github.com/xiyaowong/transparent.nvim
    {"xiyaowong/transparent.nvim", name = "transparent"},

    -- Cmd autocomplete https://github.com/gelguy/wilder.nvim
    {"gelguy/wilder.nvim", name = "wilder"},

    -- Lualine https://github.com/nvim-lualine/lualine.nvim
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        dependencies = {'nvim-tree/nvim-web-devicons'}
    }, {
        "nvim-neo-tree/neo-tree.nvim",
        name = "neo-tree",

        -- Git branch
        branch = "v3.x",

        -- Plugins reqired for neo-tree
        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim", {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                "s1n7ax/nvim-window-picker",
                name = "window-picker",
                event = "VeryLazy",
                version = "2.*"
            }
        }
    }, {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old

        build = ":TSUpdate",
        dependencies = {{"nvim-treesitter/nvim-treesitter-textobjects"}},
        cmd = {"TSUpdateSync"},
        keys = {
            {"<c-space>", desc = "Increment selection"},
            {"<bs>", desc = "decrement selection", mode = "x"}
        }
    }, -- https://github.com/nvim-treesitter/playground
    {
        "nvim-treesitter/playground",

        config = function()
            local status, configs = pcall(require, "nvim-treesitter.configs")
            if not status then
                print("Treesitter Playground isn't working!")
                return
            end
            configs.setup({
                playground = {
                    enable = true,
                    disable = {},
                    updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
                    persist_queries = false, -- Whether the query persists across vim sessions
                    keybindings = {
                        toggle_query_editor = 'o',
                        toggle_hl_groups = 'i',
                        toggle_injected_languages = 't',
                        toggle_anonymous_nodes = 'a',
                        toggle_language_display = 'I',
                        focus_language = 'f',
                        unfocus_language = 'F',
                        update = 'R',
                        goto_node = '<cr>',
                        show_help = '?'
                    }
                }
            })
        end
    }, {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {'nvim-lua/plenary.nvim'}
    }, {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'}, -- Required
            { -- Optional
                'williamboman/mason.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end
            }, {'williamboman/mason-lspconfig.nvim'}, -- Optional
            -- Autocompletion
            {'hrsh7th/nvim-cmp'}, -- Required
            {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lsp'}, -- Required
            {'hrsh7th/cmp-nvim-lua'}, -- Snippets
            {'L3MON4D3/LuaSnip'}, -- Required
            {'rafamadriz/friendly-snippets'}
        }

    }, {'jose-elias-alvarez/null-ls.nvim', event = "VeryLazy"}, {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        -- build = "cd app && yarn install",
        build = ":call mkdp#util#install()"
    }
})
