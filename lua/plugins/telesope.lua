return {
    'nvim-telescope/telescope.nvim',

    tag = '0.1.1',

    dependencies = {
        'nvim-lua/plenary.nvim'
    },

    keys = {
        {"<leader>ff", function () require('telescope.builtin').find_files() end, desc = "[F]ind [F]iles" },
        {"<leader>fw", function () require('telescope.builtin').grep_string() end, desc = "[F]ind [W]ord" },
        {"<C-Space>",  function () require('telescope.builtin').buffers() end, desc = "Active Buffers" },
        {"<leader>fh", function () require('telescope.builtin').help_tags() end, desc = "[F]ind [H]elp" },
        {"<leader>fs", function () require('telescope.builtin').lsp_document_symbols({symbol_width = 50}) end, desc = "[F]ind [S]ymbols" },
    },

    config = function ()
        require('telescope').setup {
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
            },
        }
    end

}
