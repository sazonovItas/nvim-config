# Introduction

The repo hosts my Neovim config for Linux.
`init.lua` is the config entry point for terminal Neovim.

That my first version of configuration.

# To be continued...

# Things that need to be improved

1. Structure of the plugins that depend on each other, and using table:

```lua
local M = {}

-- Some functions
M.theme = function()
end

...

return M
```

2. Plugins that have to be improved:
   - [ ] stop using lsp-zero
   - [ ] [nvim-dap](https://github.com/mfussenegger/nvim-dap) + special plugins:
     - [ ] [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) add some dap ui;
     - [ ] [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim) to close gaps between nvim-dap and mason;
     - [ ] [dap-go](https://github.com/leoluz/nvim-dap-go) for debugging golang;
     - ...
   - [ ] [toggleterm](https://github.com/akinsho/toggleterm.nvim) terminal integration;
   - [ ] [edgy](https://github.com/folke/edgy.nvim) neotree on the right side;
   - [ ] [dashboard](https://github.com/akinsho/toggleterm.nvim) nvim preview;
   - [ ] [lazygit](https://github.com/jesseduffield/lazygit) better git manipulation;
   - ...
