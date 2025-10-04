
return {
    {
        "ellisonleao/gruvbox.nvim",
        tag = "2.0.0",
        priority = 1000,
        config = function()
            local opts = {
                contrast = "hard",          -- 可以提高对比度: "hard", "soft" 或空字符串
                transparent_mode = false,   -- 启用透明背景
            }

            require("gruvbox").setup(opts)

            -- 设置颜色方案和背景
            vim.o.background = "dark"
            vim.cmd("colorscheme gruvbox")

            -- 可选: 设置终端颜色以匹配主题
            if vim.fn.has("termguicolors") then
                vim.o.termguicolors = true
            end
        end,
    },
}
