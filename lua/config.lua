-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Highlight current line
vim.opt.cursorline = true

---- Keybinds
vim.o.updatetime = 250
vim.wo.signcolumn = 'auto:1-2'

-- Buffers
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bNext<CR>", {noremap = true, silent = false})

-- Move up page
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {noremap = true, silent = true})

-- Move down page
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {noremap = true, silent = true})

-- NerdTree in backspace
vim.api.nvim_set_keymap("n", "<A-BS>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- Open Lazy
vim.keymap.set('n', '<leader>l', ':Lazy<CR>')

-- Grovbox colorscheme dark mode
vim.cmd[[colo gruvbox]]
vim.opt.background="dark"

-- Hybrid line numbering
vim.opt.relativenumber = true
vim.opt.number = true

-- Highlight Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Tab Size
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Ninja Build
vim.cmd[[abb nin make]]
vim.cmd[[set makeprg=ninja\ -C\ build/]]

-- Disable mouse. To enable set mouse=a
vim.cmd[[set mouse=]]

-- Clang Format
vim.cmd[[let g:clang_format#command = 'clang-format-6.0']]
vim.cmd[[let g:clang_format#auto_format = 1]]

-- AirLines
vim.cmd[[let g:airline#extensions#tabline#enabled = 2]]
vim.cmd[[let g:airline#extensions#tabline#formatter = 'unique_tail']]

-- Cache
require('impatient')

-- Auto Pair
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- NerdTree
require('nvim-tree').setup{}
