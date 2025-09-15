
return {
    {
        url = "git@github.com:lewis6991/gitsigns.nvim",
        tag = "v1.0.2",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.configs.gitsigns")
        end
    },
}

