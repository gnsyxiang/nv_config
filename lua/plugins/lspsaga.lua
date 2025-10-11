
return {
    {
        "nvimdev/lspsaga.nvim",
        event = "LspAttach",                -- 在 LSP 附加到缓冲区时加载这个插件，实现延迟加载
        dependencies = {
            { "nvim-tree/nvim-web-devicons" },
            { "nvim-treesitter/nvim-treesitter" },
        },
        config = function()
            require("lspsaga").setup({
                -- UI 配置
                ui = {
                    title = true,           -- 显示窗口标题
                    border = "single",      -- 边框样式: single, double, rounded, solid, shadow
                    winblend = 0,           -- 窗口透明度
                    expand = "",           -- 展开图标
                    collapse = "",         -- 折叠图标
                    code_action = "💡",     -- 代码操作图标
                    incoming = " ",        -- 传入调用图标
                    outgoing = " ",        -- 传出调用图标
                    hover = ' ',           -- 悬停图标
                    kind = {},              -- 类型图标（会自动从 nvim-web-devicons 获取）
                },

                -- 悬停配置
                hover = {
                    max_width = 0.9,        -- 最大宽度（屏幕宽度的百分比）
                    max_height = 0.8,       -- 最大高度（屏幕高度的百分比）
                    open_link = "gx",       -- 打开链接的快捷键
                    open_browser = "open",  -- 打开浏览器命令（macOS）
                },

                -- 符号大纲
                outline = {
                    win_position = "right", -- 大纲窗口位置: left, right
                    win_width = 30,         -- 大纲窗口宽度
                    auto_preview = true,    -- 自动预览
                    show_detail = true,     -- 显示详细信息
                    auto_refresh = true,    -- 自动刷新
                    keys = {                        -- 大纲键位
                        jump = "o",
                        expand_collapse = "u",
                        quit = "q",
                    },
                },

                -- 诊断配置
                diagnostic = {
                    show_code_action = true,        -- 显示代码操作
                    show_layout = "float",          -- 布局: float, normal
                    show_normal_height = 10,        -- 正常布局高度
                    jump_num_shortcut = true,       -- 使用数字快捷键跳转
                    max_width = 0.8,                -- 最大宽度
                    max_height = 0.6,               -- 最大高度
                    text_hl_follow = true,          -- 文本高亮跟随
                    border_follow = true,           -- 边框跟随
                    extend_relatedInformation = false, -- 扩展相关信息
                    diagnostic_only_current = false, -- 仅显示当前行的诊断
                    keys = {
                        exec_action = "o",          -- 执行操作
                        quit = "q",                 -- 退出
                        toggle_or_jump = "<CR>",    -- 切换或跳转
                        quit_in_show = { "q", "<ESC>" }, -- 在显示中退出
                    },
                },

                -- 代码操作
                code_action = {
                    num_shortcut = true,            -- 使用数字快捷键
                    show_server_name = true,        -- 显示服务器名称
                    extend_gitsigns = false,        -- 扩展 gitsigns
                    keys = {
                        quit = "q",                 -- 退出
                        exec = "<CR>",              -- 执行
                    },
                },

                -- 实现
                implement = {
                    enable = false,                 -- 启用实现功能
                    sign = true,                    -- 显示标记
                    virtual_text = false,           -- 虚拟文本
                    priority = 100,                 -- 优先级
                },

                -- 调用层次结构
                callhierarchy = {
                    layout = "float",               -- 布局: float, normal
                    keys = {
                        edit = "e",                 -- 编辑
                        vsplit = "v",               -- 垂直分割
                        split = "h",                -- 水平分割
                        tabe = "t",                 -- 标签页
                        quit = "q",                 -- 退出
                        shuttle = "[]",             -- 在层次间移动
                        toggle_or_req = "u",        -- 切换或请求
                        close = "<C-c>k",           -- 关闭
                    },
                },

                -- 灯光 bulb（代码操作提示）
                lightbulb = {
                    enable = false,                  -- 启用
                    enable_in_insert = true,        -- 在插入模式启用
                    sign = true,                    -- 显示标记
                    sign_priority = 40,             -- 标记优先级
                    virtual_text = true,            -- 虚拟文本
                },

                -- 滚动预览
                scroll_preview = {
                    scroll_down = "<C-f>",          -- 向下滚动
                    scroll_up = "<C-b>",            -- 向上滚动
                },

                -- 查找器
                finder = {
                    max_height = 0.5,               -- 最大高度
                    left_width = 0.3,               -- 左侧宽度
                    right_width = 0.5,              -- 右侧宽度
                    default = "ref+imp",            -- 默认模式: ref+imp, ref, imp
                    methods = {                     -- 查找方法
                        tyd = "textDocument/typeDefinition",
                        tid = "textDocument/typeDefinition",
                        t = "textDocument/typeDefinition",
                        d = "textDocument/definition",
                        i = "textDocument/implementation",
                        r = "textDocument/references",
                    },
                    layout = "float",               -- 布局: float, normal
                    silent = false,                 -- 静默模式
                    -- silent = true,              -- 关键优化：禁用查找状态输出
                    filter = {},                    -- 过滤器
                    fname_sub = nil,                -- 文件名替换
                    sp_inexist = false,             -- 显示不存在的符号
                    include_declaration = false,    -- 包含声明
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

                -- 定义预览
                definition = {
                    width = 0.6,                    -- 宽度
                    height = 0.5,                   -- 高度
                    save_pos = false,               -- 保存位置
                    quit = "q",                     -- 退出
                    edit = "<C-c>o",                -- 编辑
                },

                -- 重命名
                rename = {
                    quit = "<C-c>",                 -- 退出
                    exec = "<CR>",                  -- 执行
                    in_select = true,               -- 在选中模式
                    auto_save = false,              -- 自动保存
                    whole_project = true,           -- 整个项目
                    confirm = "<CR>",               -- 确认
                    keys = {                    -- 重命名键位
                        quit = "q",
                        exec = "<CR>",
                        select = "x",
                    },
                },

                -- 符号信息
                symbol_in_winbar = {
                    enable = false,                 -- 启用（需要 Neovim 0.8+）
                    separator = "  ",              -- 分隔符
                    hide_keyword = false,           -- 隐藏关键字
                    show_file = true,               -- 显示文件
                    folder_level = 1,               -- 文件夹级别
                    color_mode = true,              -- 颜色模式
                    delay = 300,                    -- 延迟
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
            })

            -- 自定义快捷键设置
            local keymap = vim.keymap.set
            local function opts(desc)
                return {
                    desc = 'nvim-tree: ' .. desc,
                    buffer = bufnr,
                    noremap = true,
                    silent = true,
                    nowait = true}
            end

            keymap("n", "gd",           "<cmd>Lspsaga peek_definition<CR>",         opts("Peek Definition"))        -- 跳转到定义 (预览)
            keymap("n", "gD",           "<cmd>Lspsaga goto_definition<CR>",         opts("Goto Definition"))        -- 跳转到定义 (直接跳转)
            keymap("n", "gh",           "<cmd>Lspsaga finder<CR>",                  opts(""))                       -- 查找引用/实现等

            keymap("n", "K",            "<cmd>Lspsaga hover_doc<CR>",               opts("Hover Doc"))              -- 悬停文档

            keymap("n", "<leader>o",    "<cmd>Lspsaga outline<CR>",                 opts("Outline"))                -- 打开大纲

            keymap("n", "<leader>rn",   "<cmd>Lspsaga rename<CR>",                  opts("Rename"))                 -- 重命名
            keymap("n", "<leader>rN",   "<cmd>Lspsaga rename ++project<CR>",        opts("Rename Project"))         -- 重命名 (项目范围)

            keymap("n", "<leader>d",    "<cmd>Lspsaga show_line_diagnostics<CR>",   opts("Line Diagnostics"))       -- 显示行诊断
            keymap("n", "<leader>c",    "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts("Cursor Diagnostics"))     -- 显示光标诊断
            keymap("n", "[e",           "<cmd>Lspsaga diagnostic_jump_prev<CR>",    opts(""))                       -- 跳转到上一个诊断
            keymap("n", "]e",           "<cmd>Lspsaga diagnostic_jump_next<CR>",    opts(""))                       -- 跳转到下一个诊断
            keymap("n", "[E",           function() require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR }) end, opts(""))-- 跳转到上一个错误
            keymap("n", "]E",           function() require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR }) end, opts(""))-- 跳转到下一个错误

            -- 调用层次结构
            keymap("n", "<Leader>ci",   "<cmd>Lspsaga incoming_calls<CR>",          opts("Incoming Calls"))         -- 传入调用，显示调用当前函数的所有地方，即"谁调用了这个函数"
            keymap("n", "<Leader>co",   "<cmd>Lspsaga outgoing_calls<CR>",          opts("Outgoing Calls"))         -- 传出调用，显示当前函数内部调用的所有函数，即"这个函数调用了谁"

            -- 终端命令
            keymap("n", "<A-t>",        "<cmd>Lspsaga term_toggle<CR>",             opts(""))
            keymap("t", "<ESC>",        "<C-\\><C-n>",                              opts(""))

            keymap({"n", "v"},  "<leader>ca", "<cmd>Lspsaga code_action<CR>",       opts("Code Action"))            -- 代码操作
        end,
    },
}

