local lsp_zero = require("lsp-zero")

lsp_zero.preset("recommended")

lsp_zero.ensure_installed({
    "lua_ls", "clangd", "asm_lsp", "jsonls", "bashls", "gopls", "html",
    "tsserver", "cssls"
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp_zero.defaults.cmp_mappings({
    ['<S-Tab>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<Tab>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({select = true}),
    ['<C-c>'] = cmp.mapping.complete()
})

lsp_zero.setup_nvim_cmp({mapping = cmp_mappings})

lsp_zero.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {error = 'E', warn = 'W', hint = 'H', info = 'I'}
})

lsp_zero.on_attach(function(client, bufnr)
    local opts = {buffer = bufnr, remap = false}
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<leader>vws",
                   function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set("n", "<leader>vd",
                   function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end,
                   opts)
    vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end,
                   opts)
    vim.keymap
        .set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end,
                   opts)

    if client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
    end
end)

local lspconfig = require("lspconfig")
local util = require("lspconfig.util")

lspconfig.gopls.setup({
    -- on_attach = on_attach,
    -- capabilities = capabilities,
    cmd = {"gopls"},
    filetypes = {"go", "gomod", "gowork", "gotmpl"},
    root_dir = util.root_pattern("go.work", "go.mod", ".git"),
    settings = {
        gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {unusedparams = true}
        }
    }
})

lspconfig.clangd.setup({
    cmd = {
        -- see clangd --help-hidden
        "clangd", "--background-index",
        -- by default, clang-tidy use -checks=clang-diagnostic-*,clang-analyzer-*
        -- to add more checks, create .clang-tidy file in the root directory
        -- and add Checks key, see https://clang.llvm.org/extra/clang-tidy/
        "--clang-tidy", "--completion-style=bundled", "--cross-file-rename",
        "--header-insertion=iwyu"
    },
    filetypes = {"c", "cpp", "objc", "objcpp"},
    init_options = {
        clangdFileStatus = true, -- Provides information about activity on clangd’s per-file worker thread
        usePlaceholders = true,
        completeUnimported = true,
        semanticHighlighting = true
    },
    single_file_support = true
})
lsp_zero.setup()

vim.diagnostic.config({virtual_text = true})
