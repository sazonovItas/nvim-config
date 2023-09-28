-- set leader key to space
vim.g.mapleader = " "

-- for conciseness
local keymap = vim.keymap

----------------------
-- General Keymaps
----------------------

-- use jk too exit insert mode
keymap.set("i", "jk", "<ESC>")

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- tab management
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-----------------------
-- Plugin Keybinds
-----------------------

-- tmux win navigator and vim maximazer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")
keymap.set("n", "<C-h>", ":TmuxNavigateRight<CR>")
keymap.set("n", "<C-j>", ":TmuxNavigateUp<CR>")
keymap.set("n", "<C-k>", ":TmuxNavigateDown<CR>")
keymap.set("n", "<C-l>", ":TmuxNavigateLeft<CR>")

-- bufferline
keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>")
keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>")
keymap.set("n", "<leader>bpk", ":BufferLinePick<CR>")
keymap.set("n", "<leader>bpc", ":BufferLinePickClose<CR>")

-- neo-tree
keymap.set("n", "<leader>e", ":Neotree toggle<CR>") -- toggle file explorer
keymap.set("n", "<leader>te", ":Neotree focus<CR>") -- toggle file explorer
keymap.set("n", "<leader>tb", ":Neotree buffers focus<CR>") -- toggle buffers tree
keymap.set("n", "<leader>tg", ":Neotree git_status focus<CR>") -- toggle git_status tree
keymap.set("n", "<leader>ts", ":Neotree document_symbols focus<CR>") -- togglt document_symbols tree

-- telescope
keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fb", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fh", ":Telescope help_tags<CR>")

-- markdown
keymap.set("n", "<leader>mdp", ":MarkdownPreview<CR>")
keymap.set("n", "<leader>mds", ":MarkdownPreviewStop<CR>")
keymap.set("n", "<leader>mdt", ":MarkdownPreviewToggle<CR>")
