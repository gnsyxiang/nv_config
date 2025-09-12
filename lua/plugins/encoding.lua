
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
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer' },
                })
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
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                    { name = 'cmdline' }
                })
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
            {
                url = "git@github.com:mason-org/mason.nvim.git",
                tag = "v2.0.1",
                config = function()
                    require("mason").setup({
                        ui = {
                            icons = {
                                package_installed = "✓",
                                package_pending = "➜",
                                package_uninstalled = "✗"
                            }
                        }
                    })
                end
            },
            {url = "git@github.com:mason-org/mason-lspconfig.nvim", tag = "v2.1.0"},
            {url = "git@github.com:hrsh7th/cmp-nvim-lsp"},
        },
        config = function()
            local mason_lspconfig = require('mason-lspconfig')
            local lspconfig = require("lspconfig")
            local capabilities = require('cmp_nvim_lsp').default_capabilities()

            mason_lspconfig.setup({
                ensure_installed = {"clangd"},
                automatic_installation = true,
            })

            -- 设置 clangd
            lspconfig.clangd.setup({
                capabilities = capabilities,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--suggest-missing-includes",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                },
            })

            -- LSP 按键映射
            vim.keymap.set('n', '<leader>d', vim.diagnostic.open_float, { desc = "打开诊断信息" })
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "上一个诊断" })
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "下一个诊断" })
            vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "诊断列表" })

            -- 使用 LspAttach 自动配置映射
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts, { desc = "转到声明" })
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts, { desc = "转到定义" })
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts, { desc = "悬停信息" })
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts, { desc = "转到实现" })
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts, { desc = "签名帮助" })
                    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts, { desc = "添加工作区文件夹" })
                    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts, { desc = "移除工作区文件夹" })
                    vim.keymap.set('n', '<leader>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts, { desc = "列出工作区文件夹" })
                    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts, { desc = "类型定义" })
                    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts, { desc = "重命名" })
                    vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts, { desc = "代码操作" })
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts, { desc = "引用" })
                end,
            })
        end,
    },
}

