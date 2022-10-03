return {
    'neovim/nvim-lspconfig',

    event = "BufReadPre",

    dependencies = {
        'hrsh7th/cmp-nvim-lsp',
    },

    servers = function ()

        local on_attach = function (_, bufnr)
            local nmap = function(keys, func, desc)
                if desc then
                    desc = 'LSP: ' .. desc
                end

                vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
            end

            nmap("K", vim.lsp.buf.hover, 'Hover Documentation')
            nmap("gd", vim.lsp.buf.definition, '[G]oto [D]efinition')
            nmap("gi", vim.lsp.buf.implementation, '[G]oto [I]mplementation')
        end

        -- Need to add here the lsp (and its config) to activate it
        return {
            cmake = {},

            clangd = {
                on_attach = on_attach,
                cmd = {"/home/tester/Documents/clangd_15.0.3/bin/clangd"},
            },

            lua_ls = {
                settings = {
                    Lua = {
                        runtime = {
                            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                            version = 'LuaJIT',
                        },
                        diagnostics = {
                            -- Get the language server to recognize the `vim` global
                            globals = {'vim'},
                        },
                        workspace = {
                            -- Make the server aware of Neovim runtime files
                            library = vim.api.nvim_get_runtime_file("", true),
                            checkThirdParty = false,
                        },
                        -- Do not send telemetry data containing a randomized but unique identifier
                        telemetry = {
                            enable = false,
                        },
                    },
                },
            }
        }
    end,

    config = function (opts)
        local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

        local servers = opts.servers()
        for server, _ in pairs(servers) do
            local server_opts = servers[server] or {}
            server_opts.capabilities = capabilities

            require('lspconfig')[server].setup(server_opts);
        end

    end,

}
