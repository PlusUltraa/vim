-- Automatically install packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

return require('packer').startup(function()
    -- NVIM LSP
    use 'neovim/nvim-lspconfig'

    ---- Treesitter
    use { 'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }
    -- Additional text objects via treesitter
    use { 'nvim-treesitter/nvim-treesitter-textobjects',
        after = 'nvim-treesitter',
    }

    -- Cache
    use 'lewis6991/impatient.nvim'

	-- Gruvbox
    use "ellisonleao/gruvbox.nvim"

    -- Log Syntax
    use 'mtdl9/vim-log-highlighting'

    use 'nvim-lua/plenary.nvim'

    -- Status line
    use 'nvim-lualine/lualine.nvim'

    -- Auto Complete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- Auto Pair
    use 'windwp/nvim-autopairs'

    -- Clang format
    use 'rhysd/vim-clang-format'

    -- Vim Icons
    use 'ryanoasis/vim-devicons'

    -- AirLines
    use 'vim-airline/vim-airline'

    -- Marks
    use 'kshenoy/vim-signature'

    -- Surround
    use 'tpope/vim-surround'

    -- Fast Fold
    use 'konfekt/fastfold'

    -- Git Gutter
    use 'airblade/vim-gitgutter'

    -- Nerd Tree
    use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', }, tag = 'nightly' }

    -- FZF
    --use { 'ibhagwan/fzf-lua', requires = { 'kyazdani42/nvim-web-devicons' } }

    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0',
    -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    -- Debugger
    use 'mfussenegger/nvim-dap'
    use 'nvim-telescope/telescope-dap.nvim'
    use 'rcarriga/nvim-dap-ui'
    use 'theHamsta/nvim-dap-virtual-text'
end)
