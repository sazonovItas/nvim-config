local on_attach = function(client, bufnr)
    local opts = {bufnr = bufnr, remap = false}
    local function buf_set_keymap(...)
        vim.api.nvim_buf_set_keymap(bufnr, ...)
    end

    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- Mappings.
    buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
    buf_set_keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
    buf_set_keymap("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    buf_set_keymap("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    buf_set_keymap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>D", "<cmd>Telescope lsp_type_definitions<CR>",
                   opts)
    buf_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
    buf_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>lr", "<cmd>LspRestart<CR>", opts)
    buf_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>",
                   opts)
    buf_set_keymap("n", "<leader>dn",
                   "<cmd>lua vim.diagnostic.goto_next({ float = false })<CR>",
                   opts)
    buf_set_keymap("n", "<leader>dN",
                   "<cmd>lua vim.diagnostic.goto_prev({ float = false })<CR>",
                   opts)

    -- Auto formatting
    if client.server_capabilities.documentFormattingProvider and client.name ~=
        "lua_ls" then
        vim.api.nvim_create_autocmd({"BufWritePre"}, {
            buffer = bufnr,
            callback = function()
                vim.lsp.buf.format({
                    filter = function(cli)
                        return cli.name == client.name
                    end
                })
            end,
            group = group
        })
    end

    if client.server_capabilities["documentSymbolProvider"] then
        require("nvim-navic").attach(client, bufnr)
    end
end

local lspconfig = require("lspconfig")
local util = require("lspconfig/util")
local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp
                                                                      .protocol
                                                                      .make_client_capabilities())

local runtime_path = vim.split(package.path, ";", {})
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")
require("lspconfig")["lua_ls"].setup({
    capabilities = capabilities,
    on_attach = on_attach,
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
    filetypes = {
        "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx"
    },
    root_dir = util.root_pattern("package.json", "tsconfig.json",
                                 "jsconfig.json", ".git")
})

lspconfig["html"].setup({
    cmd = {"html-languageserver", "--stdio"},
    filetypes = {"html"},
    init_options = {
        configurationSection = {"html", "css", "javascript"},
        embeddedLanguages = {css = true, javascript = true}
    }
})

lspconfig["jsonls"].setup({on_attach = on_attach, capabilities = capabilities})
lspconfig["cssls"].setup({on_attach = on_attach, capabilities = capabilities})
lspconfig["bashls"].setup({capabilities = capabilities, on_attach = on_attach})
lspconfig["cmake"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {CMake = {filetypes = {"cmake", "CMakeLists.txt"}}}
})
