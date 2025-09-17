
return {
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
    {
        url = "git@github.com:nvimdev/lspsaga.nvim",
        event = "LspAttach", -- 在 LSP 附加到缓冲区时加载这个插件，实现延迟加载
        dependencies = {
            url = "git@github.com:nvim-tree/nvim-web-devicons", -- 可选，但强烈推荐
            url = "git@github.com:nvim-treesitter/nvim-treesitter", -- 可选，但同样推荐
        },
        config = function()
            require("plugins.configs.lspsaga")
        end,
    },
    {
        url = "git@github.com:nvim-treesitter/nvim-treesitter",
        tag = "v0.10.0",
        build = ":TSUpdate",  -- 首次安装后自动更新语法解析器
        config = function()
            require("plugins.configs.nvim-treesitter")
        end,
    },
    {
        url = "git@github.com:nvim-telescope/telescope.nvim",
        tag = "0.1.8",
        dependencies = {
            { url = "git@github.com:nvim-lua/plenary.nvim"},
            { url = "git@github.com:nvim-tree/nvim-web-devicons"}, -- 可选（用于图标支持）

            { url = "git@github.com:nvim-telescope/telescope-fzf-native.nvim", build = "make" },    -- 性能优化扩展
            { url = "git@github.com:nvim-telescope/telescope-ui-select.nvim"},      -- UI 选择扩展
            {
                url = "git@github.com:debugloop/telescope-undo.nvim", -- 撤销历史扩展
                config = function() vim.keymap.set("n", "<leader>fu", "<cmd>Telescope undo<cr>", { desc = "Undo History" }) end,
            },
        },
        config = function()
            require("plugins.configs.telescope")
        end
    },
    {
        url = "git@github.com:danymat/neogen",
        tag = "2.20.0",
        dependencies = {
            url = "git@github.com:nvim-treesitter/nvim-treesitter",
            url = "git@github.com:L3MON4D3/LuaSnip",
        },
        ft = { "cpp", "c", "h", "hpp", "python", "lua", "javascript", "typescript", "go"},
        config = function()
            require("plugins.configs.annotation")
        end
    },

    -- 用于触发代码片段的插件（可选但推荐）
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
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
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

    -- LuaSnip 代码片段引擎
    {
        url = "git@github.com:L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            url = "git@github.com:rafamadriz/friendly-snippets"
        },
        config = function()
            -- require("luasnip").config.setup({})

            require("luasnip").config.set_config({
                history = true,
                updateevents = "TextChanged,TextChangedI",
            })
            require("luasnip.loaders.from_vscode").lazy_load()


            require("luasnip").config.setup({
                -- 启用详细日志
                history = true,
                updateevents = "TextChanged,TextChangedI",
                enable_autosnippets = true,
                -- 存储日志到文件
                store_selection_keys = "<Tab>",
            })

            -- 添加调试输出
            vim.notify("Loading LuaSnip snippets...")

            -- 尝试加载并捕获任何错误
            local status, err = pcall(function()
                require("luasnip.loaders.from_vscode").load({
                    paths = { "~/.config/nvim/snippets" }
                })
            end)

            if not status then
                vim.notify("Error loading snippets: " .. tostring(err), vim.log.levels.ERROR)
            else
                vim.notify("Snippets loaded successfully")
            end

            -- 在配置函数内添加自定义片段是安全的
            require("luasnip").add_snippets("c", {
                require("luasnip").parser.parse_snippet("test", "This is a test snippet"),
            })

            -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })

            -- 加载友好片段（可选）
            require("luasnip.loaders.from_vscode").lazy_load()

            -- 在加载自定义片段前先清除现有片段
            -- require("luasnip").snippets = {}
            -- require("luasnip").snippet_cache = {}

            -- 加载自定义的 VS Code 格式片段
            -- require("luasnip.loaders.from_vscode").lazy_load({
            --     paths = { "~/.config/nvim/snippets/test.json" }
            -- })
            -- require("luasnip.loaders.from_vscode").lazy_load({
            --     paths = { "~/.config/nvim/snippets" }
            -- })
        end,
    },
}

