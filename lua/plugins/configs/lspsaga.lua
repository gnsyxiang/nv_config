
require("lspsaga").setup({
    finder = {
        max_height = 0.5,           -- 查找器最大高度
        default = 'ref+imp',
        silent = true,              -- 关键优化：禁用查找状态输出
        force_max_height = false,   -- 是否默认保持
        keys = {                    -- 查找器键位
          -- jump_to = "p",
          expand_or_jump = "o",
          vsplit = "v",
          split = "h",
          tabe = "t",
          tabnew = "r",
          quit = "q",
          close = "<C-c>k",
        },
    },
    -- 引用设置
    reference = {
        -- 引用预览键位
        keys = {
            edit = "e",
            vsplit = "v",
            split = "h",
            tabe = "t",
            quit = "q",
        },
    },
    rename = {
        -- auto_save = false,          -- 重命名时自动保存
        -- project_max_width = 0.5,    -- 项目范围重命名
        -- project_max_height = 0.5,
        keys = {                    -- 重命名键位
            quit = "q",
            exec = "<CR>",
            select = "x",
        },
    },
    outline = {
        win_position = "right",         -- 窗口位置: "left" | "right"
        -- win_width = 30,                 -- 窗口宽度
        -- show_detail = true,             -- 显示细节
        -- auto_close = true,              -- 自动关闭
        -- auto_preview = true,            -- 自动预览
        keys = {                        -- 大纲键位
            jump = "o",
            expand_collapse = "u",
            quit = "q",
        },
    },
    lightbulb = {                       -- 灯标设置 (代码操作提示)
        enable = true,
        enable_in_insert = true,
        sign = true,
        sign_priority = 40,
        virtual_text = false,
    },
})

-- 自定义快捷键设置
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

keymap("n", "<leader>o",    "<cmd>Lspsaga outline<CR>",                 opts)       -- 打开大纲
keymap("n", "gr",           "<cmd>Lspsaga finder<CR>",                  opts)       -- 查找引用/实现等
keymap("n", "gd",           "<cmd>Lspsaga peek_definition<CR>",         opts)       -- 跳转到定义 (预览)
keymap("n", "gD",           "<cmd>Lspsaga goto_definition<CR>",         opts)       -- 跳转到定义 (直接跳转)
keymap("n", "K",            "<cmd>Lspsaga hover_doc<CR>",               opts)       -- 悬停文档
keymap("n", "<leader>rn",   "<cmd>Lspsaga rename<CR>",                  opts)       -- 重命名
keymap("n", "<leader>rN",   "<cmd>Lspsaga rename ++project<CR>",        opts)       -- 重命名 (项目范围)

keymap("n", "<leader>d",   "<cmd>Lspsaga show_line_diagnostics<CR>",    opts)       -- 显示行诊断
keymap("n", "<leader>c",   "<cmd>Lspsaga show_cursor_diagnostics<CR>",  opts)       -- 显示光标诊断
keymap("n", "[e",           "<cmd>Lspsaga diagnostic_jump_prev<CR>",    opts)       -- 跳转到上一个诊断
keymap("n", "]e",           "<cmd>Lspsaga diagnostic_jump_next<CR>",    opts)       -- 跳转到下一个诊断
keymap("n", "[E",           function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, opts)-- 跳转到上一个错误
keymap("n", "]E",           function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, opts)-- 跳转到下一个错误

-- 调用层次结构
keymap("n", "<Leader>ci",   "<cmd>Lspsaga incoming_calls<CR>",          opts)
keymap("n", "<Leader>co",   "<cmd>Lspsaga outgoing_calls<CR>",          opts)

-- 终端命令
keymap("n", "<A-t>",        "<cmd>Lspsaga term_toggle<CR>",             opts)

-- 代码操作
keymap({"n", "v"},  "<leader>ca", "<cmd>Lspsaga code_action<CR>",       opts)

