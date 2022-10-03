return {
    'nvim-lualine/lualine.nvim',

    config = function ()
        require('lualine').setup{
            options = {
                theme = 'gruvbox',
            },

            tabline = {
                lualine_a = {'buffers'},
                lualine_z = {'tabs'}
            },

        }
    end
}
