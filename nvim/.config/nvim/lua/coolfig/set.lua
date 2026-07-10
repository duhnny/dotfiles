-- general keymaps
vim.g.mapleader = " "

vim.keymap.set("n", "<C-f>", vim.cmd.Ex)            -- Ctrl+F: open file tree

vim.keymap.set("n", "<C-z>", vim.cmd.undo)          -- Ctrl+Z: undo
vim.keymap.set("n", "<CS-z>", vim.cmd.redo)         -- Ctrl+Shift+Z: redo
vim.keymap.set("n", "U", vim.cmd.redo)              -- U: redo

vim.keymap.set("v", "$", "g_")                      -- do not select newline
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])  -- Space+Y: copy to clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "i", "v"}, "<C-s>", vim.cmd.w) -- Ctrl+S: save

-- terminal
vim.keymap.set("n", "<C-t>", "<cmd>split<CR> <Bar> <C-W>w <C-w>-<C-w>-<C-w>-<C-w>-<C-w>-<C-w>- <cmd>terminal<CR> <Bar> i")
vim.keymap.set("t", "<C-t>", "<C-\\><C-n><cmd>close<CR>")
vim.keymap.set("t", "<Esc>", "<C-\\><C-n>")

-- lsp
vim.keymap.set("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>")

-- indenting
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- backups
-- vim.opt.swapfile = false
-- vim.opt.backup = false
-- vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
-- vim.opt.undofile = true

-- search
vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- performance
vim.opt.updatetime = 50

-- aesthetics
vim.opt.nu = true -- add numbers
vim.opt.wrap = false -- disable line wrapping
-- vim.opt.colorcolumn = "90" -- vertical bar
vim.opt.termguicolors = true
vim.cmd.colorscheme("kanagawa") -- catppuccin colorscheme

-- path (for Windows)
-- vim.g.netrw_cygwin = 0
-- vim.g.netrw_scp_cmd = '"C:\\Windows\\System32\\OpenSSH\\scp.exe" -q'
