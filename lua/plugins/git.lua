
return {
    {
        url = "git@github.com:lewis6991/gitsigns.nvim",
        tag = "v1.0.2",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("plugins.configs.gitsigns")
        end
    },
    {
        url = "git@github.com:kdheepak/lazygit.nvim",
        lazy = true,
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            { url = "git@github.com:nvim-lua/plenary.nvim"},
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
}

