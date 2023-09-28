local status_mason, mason = pcall(require, "mason")
if not status_mason then
    print("Mason plugin isn't available!")
    return
end

local status_masonlsp, masonlsp = pcall(require, "mason-lspconfig")
if not status_masonlsp then
    print("Mason-lspconfig plugin isn't available!")
    return
end

local status_mason_dap, masondap = pcall(require, "mason-nvim-dap")
if not status_mason_dap then
    print("Mason dap plugin isn't avaliable!")
    return
end

local mason_settings = require("itas.plugins.lsp.mason_settings")
mason.setup({
    ui = {icons = mason_settings.icons(), keymaps = mason_settings.keymaps()}
})
masonlsp.setup({ensure_installed = mason_settings.ensure_installed_lsp()})
masondap.setup({
    ensure_installed = mason_settings.ensure_installed_dap(),
    function(config)
        -- all sources with no handler get passed here

        -- Keep original functionality
        require('mason-nvim-dap').default_setup(config)
    end
})
