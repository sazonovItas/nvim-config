local status, lint = pcall(require, "lint")
if not status then
    print("Linter plugin isn't avaliable")
    return
end

lint.linters_by_ft = {
    javascript = {'eslint'},
    typescript = {'eslint'},
    golang = {'golangci_lint'},
    cmake = {'cmakelint'}
}
vim.api.nvim_create_autocmd({"BufWritePost"},
                            {callback = function() lint.try_lint() end})
