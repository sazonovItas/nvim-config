local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local status, null_ls = pcall(require, "null-ls")
if not status then return end

local formatting = null_ls.builtins.formatting
local diagnostic = null_ls.builtins.diagnostics
local opts = {
  sources = {
    formatting.goimports_reviser, formatting.gofumpt, formatting.golines,
    formatting.clang_format, formatting.cmake_format, formatting.asmfmt,
    formatting.lua_format, formatting.prettier, diagnostic.eslint,
    diagnostic.golangci_lint
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end
      })
    end
  end
}

null_ls.setup(opts)
