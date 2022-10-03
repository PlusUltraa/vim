-- Disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- Highlight current line
vim.opt.cursorline = true

---- Keybinds
-- Easy way to use :
vim.g.mapleader = " "
vim.keymap.set({'n', 'v'}, "<Space>", ":")

-- Buffers
vim.api.nvim_set_keymap("n", "<Tab>", ":bnext<CR>", {noremap = true, silent = false})
vim.api.nvim_set_keymap("n", "<S-Tab>", ":bNext<CR>", {noremap = true, silent = false})

local builtin = require('telescope.builtin')
-- Find file in current directory
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
-- Find word in corrent directory
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {})
-- Buffer List
vim.keymap.set('n', '<C-Space>', builtin.buffers, {})
-- Help tags
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Document Symbols
vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})

-- Move up page
vim.api.nvim_set_keymap("n", "<C-u>", "<C-u>zz", {noremap = true, silent = true})

-- Move down page
vim.api.nvim_set_keymap("n", "<C-d>", "<C-d>zz", {noremap = true, silent = true})

-- NerdTree in backspace
vim.api.nvim_set_keymap("n", "<A-BS>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})

-- Hybrid line numbering
vim.opt.relativenumber = true
vim.opt.number = true

-- Grovbox colorscheme dark mode
require("gruvbox").setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = false,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd[[colo gruvbox]]
vim.opt.background="dark"

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

-- Status line
require('lualine').setup{
    options = {
        theme = 'gruvbox'
    }
}

-- Cache
require('impatient')

-- Auto Pair
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})

-- NerdTree
require('nvim-tree').setup{}

-- Treesitter
require('nvim-treesitter.configs').setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "cpp", "lua", "help" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
  textobjects = {
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']f'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Debug
vim.keymap.set("n", "<F5>", ":lua require('dap').continue()<CR>")
vim.keymap.set("n", "<F9>", ":lua require('dap').step_over()<CR>")
vim.keymap.set("n", "<F10>", ":lua require('dap').step_into()<CR>")
vim.keymap.set("n", "<F11>", ":lua require('dap').setp_out()<CR>")
vim.keymap.set("n", "<F12>", ":lua require('dap').toggle_breakpoint()<CR>")

local dap = require('dap')

dap.adapters.lldb = {
    type = 'executable',
    command = '/home/linuxbrew/.linuxbrew/bin/lldb-vscode',
    name = 'lldb'
}

dap.configurations.cpp = {
  {
    name = 'Launch',
    type = 'lldb',
    request = 'launch',
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    -- runInTerminal = false,
  },
}

-- If you want to use this for Rust and C, add something like this:
--dap.configurations.c = dap.configurations.cpp
--dap.configurations.rust = dap.configurations.cpp

---- DAP UI
require("dapui").setup({
  icons = { expanded = "", collapsed = "", current_frame = "" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
  -- Use this to override mappings for specific elements
  element_mappings = {
    -- Example:
    -- stacks = {
    --   open = "<CR>",
    --   expand = "o",
    -- }
  },
  -- Expand lines larger than the window
  -- Requires >= 0.7
  expand_lines = vim.fn.has("nvim-0.7") == 1,
  -- Layouts define sections of the screen to place windows.
  -- The position can be "left", "right", "top" or "bottom".
  -- The size specifies the height/width depending on position. It can be an Int
  -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
  -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
  -- Elements are the elements shown in the layout (in order).
  -- Layouts are opened in order so that earlier layouts take priority in window sizing.
  layouts = {
    {
      elements = {
      -- Elements can be strings or table with id and size keys.
        { id = "scopes", size = 0.25 },
        "breakpoints",
        "stacks",
        "watches",
      },
      size = 40, -- 40 columns
      position = "left",
    },
    {
      elements = {
        "repl",
        "console",
      },
      size = 0.25, -- 25% of total lines
      position = "bottom",
    },
  },
  controls = {
    -- Requires Neovim nightly (or 0.8 when released)
    enabled = true,
    -- Display controls in this element
    element = "repl",
    icons = {
      pause = "",
      play = "",
      step_into = "",
      step_over = "",
      step_out = "",
      step_back = "",
      run_last = "",
      terminate = "",
    },
  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
  render = {
    max_type_length = nil, -- Can be integer or nil.
    max_value_lines = 100, -- Can be integer or nil.
  }
})

local dapui = require("dapui")

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end

require("nvim-dap-virtual-text").setup{}
