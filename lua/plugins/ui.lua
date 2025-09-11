
return {
    {
        url = "git@github.com:ellisonleao/gruvbox.nvim",
        version = "2.0.0",
        priority = 1000,
        config = function()
            require("plugins.configs.gruvbox")
        end,
    }
}
