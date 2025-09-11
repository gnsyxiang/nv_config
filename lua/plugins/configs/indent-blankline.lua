
local opts = {
    indent = { char = "│" },
    scope = { 
        enabled = true,
        show_start = false,
        show_end = false,
    },
}

require("ibl").setup(opts)

-- 自定义缩进线颜色
vim.api.nvim_set_hl(0, "IblIndent", { fg = "#454b54", nocombine = true })
vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7", nocombine = true })

