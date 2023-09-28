local dap = require("dap")

dap.adapters.codelldb = function(on_adapter)
    dap.adapters.codelldb = {type = 'server', host = '127.0.0.1', port = 13000}
end

dap.configurations.cpp = {
    {
        type = 'codelldb',
        request = 'launch',
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/',
                                'file')
        end,
        -- program = '${fileDirname}/${fileBasenameNoExtension}',
        cwd = '${workspaceFolder}',
        terminal = 'integrated'
    }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
