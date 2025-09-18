
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
            { url = "git@github.com:nvim-tree/nvim-web-devicons" }, -- 可选，但强烈推荐
            { url = "git@github.com:nvim-treesitter/nvim-treesitter" }, -- 可选，但同样推荐
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
            { url = "git@github.com:nvim-treesitter/nvim-treesitter" },
            { url = "git@github.com:L3MON4D3/LuaSnip" },
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
            { url = "git@github.com:hrsh7th/cmp-nvim-lsp"},

            { url = "git@github.com:hrsh7th/cmp-buffer"},
            { url = "git@github.com:hrsh7th/cmp-path"},
            { url = "git@github.com:hrsh7th/cmp-cmdline"},

            { url = "git@github.com:L3MON4D3/LuaSnip"},
            { url = "git@github.com:saadparwaiz1/cmp_luasnip"},

            -- url = "git@github.com:rafamadriz/friendly-snippets",
        },
        config = function()
            require("plugins.configs.snippet")
        end
    },

    -- LuaSnip 代码片段引擎
    {
        url = "git@github.com:L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
        dependencies = {
            { url = "git@github.com:rafamadriz/friendly-snippets"}
        },
        config = function()
            require("luasnip").config.setup({})

            -- 在配置函数内添加自定义片段是安全的
            require("luasnip").add_snippets("c", {
                require("luasnip").parser.parse_snippet("test", "This is a test snippet"),
            })

            -- require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })
            -- 加载自定义的 VS Code 格式片段
            require("luasnip.loaders.from_vscode").lazy_load({
                paths = { "~/.config/nvim/snippets/" }
            })

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

