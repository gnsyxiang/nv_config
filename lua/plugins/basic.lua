
return {
    {
        url = "git@github.com:nvim-lua/plenary.nvim",
        lazy = true
    },
    {
        url = "git@github.com:nvim-tree/nvim-tree.lua",
        tag = "v1.14.0",
        dependencies = {
            url = "git@github.com:nvim-tree/nvim-web-devicons"
        },
        lazy = false,
        keys = {
            { "<A-n>", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" }
        },
        config = function()
            require("plugins.configs.nvim-tree")
        end,
    },
    {
        url = "git@github.com:nvim-lualine/lualine.nvim",
        dependencies = {
            url = "git@github.com:nvim-tree/nvim-web-devicons"
        },
        config = function()
            require("plugins.configs.lualine")
        end,
    },
    {
        url = "git@github.com:kylechui/nvim-surround",
        version = "^3.0.0",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end
    },
    {
        url = "git@github.com:gcmt/wildfire.vim",
    },
    {
        url = "git@github.com:windwp/nvim-autopairs",
        event = "InsertEnter",
        config = true
        -- use opts = {} for passing setup options
        -- this is equivalent to setup({}) function
    },
}

