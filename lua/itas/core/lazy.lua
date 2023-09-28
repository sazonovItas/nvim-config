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

local status, configLazy = pcall(require, "lazy")
if not status then
    print("Lazy plugin manager isn't working!")
    return
end

configLazy.setup({
    {
        "folke/tokyonight.nvim",
        name = "tokyonight",
        lazy = false,
        priority = 2000
    }, -- colorscheme
    {"xiyaowong/transparent.nvim", name = "transparent"}, -- Transparent
    {"gelguy/wilder.nvim", name = "wilder"}, -- Cmd autocomplete
    {
        "nvim-lualine/lualine.nvim",
        name = "lualine",
        dependencies = {'nvim-tree/nvim-web-devicons'}
    }, -- Lualine
    {
        "nvim-neo-tree/neo-tree.nvim",
        name = "neo-tree",

        -- Git branch
        branch = "v3.x",

        dependencies = {
            "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim"
        }
    }, -- File explorer
    {
        "nvim-treesitter/nvim-treesitter",
        version = false, -- last release is way too old

        build = ":TSUpdate",
        dependencies = {{"nvim-treesitter/nvim-treesitter-textobjects"}},
        cmd = {"TSUpdateSync"},
        keys = {
            {"<c-space>", desc = "Increment selection"},
            {"<bs>", desc = "decrement selection", mode = "x"}
        }
    }, -- better code highlighting
    {"nvim-treesitter/playground"}, -- interesting plugin for tresitter
    {
        "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
        dependencies = {'nvim-lua/plenary.nvim'}
    }, -- Live grep, file finder and a lot of other
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            {
                'williamboman/mason.nvim',
                'jay-babu/mason-nvim-dap.nvim',
                build = function()
                    pcall(vim.api.nvim_command, 'MasonUpdate')
                end
            }, {'williamboman/mason-lspconfig.nvim'}, -- Support fast installation of LSP, DAP and formantter
            -- Autocompletion
            {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lsp'},
            {'onsails/lspkind.nvim'}, -- vscode like documentation
            {'hrsh7th/cmp-nvim-lua'}, -- Snippets
            {'L3MON4D3/LuaSnip'}, -- Required
            {'rafamadriz/friendly-snippets'}
        }

    }, -- LSP and autocompletion
    {'jose-elias-alvarez/null-ls.nvim', event = "VeryLazy"}, -- formatter need to be deleted
    {
        "iamcco/markdown-preview.nvim",
        ft = "markdown",
        build = ":call mkdp#util#install()"
    }, -- markdown preview
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons'
    }, -- tab managment
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic", "nvim-tree/nvim-web-devicons" -- optional dependency
        }
    }, -- winbar that uses nvim-navic in order to get LSP context
    {"christoomey/vim-tmux-navigator", "szw/vim-maximizer"}, -- tmux win navigator and vim maximazer
    {
        'numToStr/Comment.nvim',
        lazy = false,
        config = function() require("Comment").setup() end
    }, -- Fast comments
    {"ray-x/lsp_signature.nvim", event = "VeryLazy"}, -- Function's arguments hints
    {"folke/todo-comments.nvim", dependencies = {"nvim-lua/plenary.nvim"}}, -- Todo
    {
        'akinsho/toggleterm.nvim',
        version = "*",
        opts = {auto_scroll = true, direction = "vertical"}
    }, -- Terminal
    {
        "mfussenegger/nvim-dap",
        name = "nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui", "theHamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim"
        }
    }, -- nvim debbugger
    {"leoluz/nvim-dap-go", ft = "go"}, -- debbuger golang
    {"mfussenegger/nvim-lint", event = "VeryLazy"}, -- linter
    {
        'barrett-ruth/live-server.nvim',
        build = 'yarn global add live-server',
        config = true
    }, -- live server
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    }, -- autopairs (cmp of brackets and other pairs elements)
    {
        "norcalli/nvim-colorizer.lua",
        config = function() require("colorizer").setup() end
    }
})
