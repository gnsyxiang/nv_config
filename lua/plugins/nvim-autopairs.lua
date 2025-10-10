
return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        check_ts = true,                                                -- 启用 treesitter
        ts_config = {
            lua = { "string" },                                         -- 不配对大括号内的字符串
            javascript = { "template_string" },
            java = false,                                               -- 不检查 java 文件
        },
        disable_filetype = { "TelescopePrompt", "spectre_panel" },
        disable_in_macro = false,                                       -- 在宏录制时禁用
        disable_in_visualblock = false,                                 -- 在可视块模式下禁用
        disable_in_replace_mode = true,
        ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
        enable_moveright = true,
        enable_afterquote = true,                                       -- 引号后自动补全
        enable_check_bracket_line = true,                               -- 检查括号行
        enable_bracket_in_quote = true,
        enable_abbr = false,                                            -- 触发缩写
        break_undo = true,                                              -- 为括号对切换断点
        map_cr = true,                                                  -- 映射回车键
        map_bs = true,                                                  -- 映射退格键删除括号对
        map_c_h = false,                                                -- 映射 Ctrl+h 删除括号对
        map_c_w = false,                                                -- 映射 Ctrl+w 删除括号对
    },

    config = function(_, opts)
        require("nvim-autopairs").setup(opts)

        -- 可选：与 nvim-cmp 集成
        -- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        -- local cmp = require("cmp")
        -- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
}
