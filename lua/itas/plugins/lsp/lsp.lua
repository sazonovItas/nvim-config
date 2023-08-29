local on_attach = function(client, bufnr)
    local opts = {buffer = bufnr, noremap = true, silent = true}
    local keymap = vim.keymap.set
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
    keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>", opts)
    keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
    keymap("n", "<leader>lr", "<cmd>LspRestart<CR>", opts)
    keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
    keymap("n", "<leader>dn",
           "<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>", opts)
    keymap("n", "<leader>dN",
           "<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>", opts)

    if client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
    end
end

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
-- capabilities.offsetEncoding = {"utf-16"}
local flags = {allow_incremental_sync = true, debounce_text_changes = 200}

local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig")["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
    flags = flags,
    settings = {
        Lua = {
            runtime = {
                -- Tell the language server which version of Lua you're using (most likely LuaJIT)
                version = "LuaJIT",
                -- Setup your lua path
                path = runtime_path
            },
            diagnostics = {globals = {"vim"}},
            completion = {callSnippet = "Replace"},
            workspace = {library = vim.api.nvim_get_runtime_file("", true)},
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {enable = false},
            hint = {enable = true}
        }
    }
})

lspconfig["gopls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
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

lspconfig["clangd"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
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

lspconfig["tsserver"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    root_dir = util.root_pattern("package.json", "tsconfig.json",
                                 "jsconfig.json", ".git")
})

lspconfig["html"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
    -- cmd = { "html-lsp", "--stdio" },
    filetypes = {"html"},
    init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
    }
})

lspconfig["jsonls"].setup({on_attach = on_attach, capabilities = capabilities})
lspconfig["cssls"].setup({on_attach = on_attach, capabilities = capabilities})
lspconfig["bashls"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
    filetypes = {'sh', 'zsh', '.env', '.zshrc'}
})
lspconfig["cmake"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    flags = flags,
    settings = {CMake = {filetypes = {"cmake", "CMakeLists.txt"}}}
})
