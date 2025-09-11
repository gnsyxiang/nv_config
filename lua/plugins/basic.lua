
return {
    {
        url = "git@github.com:nvim-lua/plenary.nvim",
        lazy = true
    },
    {
        url = "git@github.com:nvim-tree/nvim-tree.lua",
        version = "v1.14.0",
        dependencies = {
            url = "git@github.com:nvim-tree/nvim-web-devicons"
        },
        lazy = false,
        keys = {
            { "<A-n>", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" }
        },
        config = function()
            require("plugins.configs.nvim-tree")  -- 加载配置文件
        end,
    },
}
