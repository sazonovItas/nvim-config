local M = {}

M.icons = function()
    local icons = {
        package_installed = "✓",
        package_pending = "➜",
        package_uninstalled = "✗"
    }
    return icons
end

M.ensure_installed_lsp = function()
    local lsp = {
        "clangd", "cmake", "json-lsp", "lua_ls", "bashls", "cssls", "tsserver",
        "html", "gopls"
    }
    return lsp
end

M.ensure_installed_dap = function()
    local dap = {"bash-debug-adapter", "go-debug-adapter", "codelldb"}
    return dap
end

M.ensure_installed_formatter = function()
    local formatter = {
        "clang-format", "cmakelang", "gofumpt", "goimports-reviser", "golines",
        "luaformatter", "prettier"
    }
    return formatter
end

M.ensure_installed_all = function()
    local all = {}
    for _, v in ipairs(M.ensure_installed_lsp()) do table.insert(all, v) end
    for _, v in ipairs(M.ensure_installed_dap()) do table.insert(all, v) end
    for _, v in ipairs(M.ensure_installed_formatter()) do
        table.insert(all, v)
    end
    return all
end

M.keymaps = function()
    local keymaps = {
        toggle_package_expand = "<CR>",
        install_package = "i",
        update_package = "u",
        check_package_version = "c",
        update_all_packages = "U",
        check_outdated_packages = "C",
        uninstall_package = "X",
        cancel_installation = "<C-i>",
        apply_language_filter = "<C-f>"
    }
    return keymaps
end

return M
