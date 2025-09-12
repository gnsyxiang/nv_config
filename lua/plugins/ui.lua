
return {
    {
        url = "git@github.com:ellisonleao/gruvbox.nvim",
        tag = "2.0.0",
        priority = 1000,
        config = function()
            require("plugins.configs.gruvbox")
        end,
    },
    {
        url = "git@github.com:lukas-reineke/indent-blankline.nvim",
        tag = "v3.9.0",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        config = function()
            require("plugins.configs.indent-blankline")
        end,
    },
}
