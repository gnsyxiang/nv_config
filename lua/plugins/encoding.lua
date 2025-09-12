
return {
    -- 自动补全插件
    {
        url = "git@github.com:hrsh7th/nvim-cmp",
        dependencies = {
            url = "git@github.com:hrsh7th/cmp-nvim-lsp",

            url = "git@github.com:hrsh7th/cmp-buffer",
            url = "git@github.com:hrsh7th/cmp-path",
            url = "git@github.com:hrsh7th/cmp-cmdline",

            url = "git@github.com:L3MON4D3/LuaSnip",
            url = "git@github.com:saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>']       = cmp.mapping.scroll_docs(-4),
                    ['<C-f>']       = cmp.mapping.scroll_docs(4),
                    ['<C-Space>']   = cmp.mapping.complete(),
                    ['<C-e>']       = cmp.mapping.abort(),
                    ['<CR>']        = cmp.mapping.confirm({ select = true }),
                    ['<Tab>']       = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>']     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources(
                    {
                        { name = 'nvim_lsp' },
                        { name = 'luasnip' },
                    }, {
                        { name = 'buffer' },
                    }
                )
            })

            -- 命令行自动补全设置
            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    {
                        { name = 'path' }
                    }, {
                        { name = 'cmdline' }
                    }
                )
            })
        end
    },

    -- 代码片段引擎
    {
        url = "git@github.com:L3MON4D3/LuaSnip",
        dependencies = {
            url = "git@github.com:rafamadriz/friendly-snippets"
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    -- lsp 配置
    {
        url = "git@github.com:neovim/nvim-lspconfig",
        tag = "v2.4.0",
        event = {"BufReadPre", "BufNewFile"},
        dependencies = {
            { url = "git@github.com:mason-org/mason.nvim", tag = "stable", },
            { url = "git@github.com:mason-org/mason-lspconfig.nvim", tag = "stable" },
            { url = "git@github.com:hrsh7th/cmp-nvim-lsp" },
        },
        config = function()
            require("plugins.configs.lsp")
        end,
    },
}

