
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
}

