
return {
    {
        "tpope/vim-fugitive",
        cmd = { "G", "Git", "Gdiffsplit", "Gread", "Gwrite", "Ggrep", "GMove", "GDelete", "GBrowse" },
        dependencies = {
            "tpope/vim-rhubarb",        -- 增强 GitHub 支持（可选）
        },
        config = function()
            -- 键位映射配置
            vim.keymap.set("n", "<leader>gs", "<cmd>Git<cr>",           { desc = "Git status" })
            vim.keymap.set("n", "<leader>gd", "<cmd>Gdiffsplit<cr>",    { desc = "Git diff" })
            vim.keymap.set("n", "<leader>gc", "<cmd>Git commit<cr>",    { desc = "Git commit" })
            vim.keymap.set("n", "<leader>gb", "<cmd>Git blame<cr>",     { desc = "Git blame" })
            vim.keymap.set("n", "<leader>gl", "<cmd>Git log<cr>",       { desc = "Git log" })
            vim.keymap.set("n", "<leader>gp", "<cmd>Git push<cr>",      { desc = "Git push" })
            vim.keymap.set("n", "<leader>gP", "<cmd>Git pull<cr>",      { desc = "Git pull" })
            vim.keymap.set("n", "<leader>gf", "<cmd>Git fetch<cr>",     { desc = "Git fetch" })

            -- " 基本操作
            -- :Git status      " 查看状态（快捷键: g? 查看帮助）
            -- :Git commit       " 提交更改
            -- :Git push         " 推送到远程
            -- :Gpull         " 从远程拉取
            --
            -- " 文件操作
            -- :Gread         " 检出当前文件（撤销修改）
            -- :Gwrite        " 添加当前文件到暂存区
            -- :Gmove         " 移动/重命名文件
            --
            -- " 比较操作
            -- :Gdiffsplit    " 分屏比较修改
            -- :Gblame        " 显示逐行提交信息
            --
            -- " 分支操作
            -- :Gbranch       " 显示/切换分支
            -- :Glog          " 查看提交历史

            -- 自定义配置（可选）
            vim.g.fugitive_legacy_commands = 0  -- 禁用旧命令
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            -- 1, 符号显示配置
            signs = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '┃' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged_enable = true,

            -- 2, 显示模式配置
            signcolumn = true,              -- 在标记列显示 Git 符号，  -- Toggle with `:Gitsigns toggle_signs`
            numhl      = false,             -- 不在行号区域高亮显示     -- Toggle with `:Gitsigns toggle_numhl`
            linehl     = false,             -- 不高亮整行               -- Toggle with `:Gitsigns toggle_linehl`
            word_diff  = false,             -- 不显示单词级别的差异     -- Toggle with `:Gitsigns toggle_word_diff`

            -- 3, Git 目录监控
            watch_gitdir = {
                -- interval = 1000,
                follow_files = true         -- 如果文件在外部被移动，自动跟踪
            },
            auto_attach = true,             -- 自动附加到 Git 仓库中的缓冲区
            attach_to_untracked = false,    -- 不为未跟踪的文件附加 gitsigns

            -- 4, 当前行责备信息
            current_line_blame = false,     -- 不在当前行显示责备信息（性能考虑）  -- Toggle with `:Gitsigns toggle_current_line_blame`
            current_line_blame_opts = {
                virt_text = true,           -- 使用虚拟文本显示
                virt_text_pos = 'eol',      -- 在行尾显示（可选：'eol' | 'overlay' | 'right_align'）
                delay = 1000,               -- 显示延迟（毫秒）
                ignore_whitespace = false,  -- 不忽略空白更改
                virt_text_priority = 100,   -- 虚拟文本的显示优先级
                use_focus = true,           -- 只在获得焦点时显示
            },
            current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',

            -- 5, 性能和行为配置
            sign_priority = 6,              -- 符号的显示优先级
            update_debounce = 100,          -- 更新防抖时间（毫秒）
            status_formatter = nil,         -- 使用默认的状态格式化器
            max_file_length = 40000,        -- 文件超过40000行时禁用gitsigns

            -- 6, 预览窗口配置
            preview_config = {
                style = 'minimal',          -- 窗口样式：简约
                relative = 'cursor',        -- 相对于光标位置
                row = 0,                    -- 行偏移
                col = 1,                    -- 列偏移
            },

            -- 键位映射配置函数
            on_attach = function(bufnr)
                local gitsigns = require('gitsigns')

                local function map(mode, l, r, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, l, r, opts)
                end

                -- Navigation
                map('n', ']c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({']c', bang = true})
                    else
                        gitsigns.nav_hunk('next')
                    end
                end)

                map('n', '[c', function()
                    if vim.wo.diff then
                        vim.cmd.normal({'[c', bang = true})
                    else
                        gitsigns.nav_hunk('prev')
                    end
                end)

                -- Actions
                map('n', '<leader>hs', gitsigns.stage_hunk)
                map('n', '<leader>hr', gitsigns.reset_hunk)

                map('v', '<leader>hs', function()
                    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('v', '<leader>hr', function()
                    gitsigns.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') })
                end)

                map('n', '<leader>hS', gitsigns.stage_buffer)
                map('n', '<leader>hR', gitsigns.reset_buffer)
                map('n', '<leader>hp', gitsigns.preview_hunk)
                map('n', '<leader>hi', gitsigns.preview_hunk_inline)

                map('n', '<leader>hb', function()
                    gitsigns.blame_line({ full = true })
                end)

                map('n', '<leader>hd', gitsigns.diffthis)

                map('n', '<leader>hD', function()
                    gitsigns.diffthis('~')
                end)

                map('n', '<leader>hQ', function() gitsigns.setqflist('all') end)
                map('n', '<leader>hq', gitsigns.setqflist)

                -- Toggles
                map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
                map('n', '<leader>tw', gitsigns.toggle_word_diff)

                -- Text object
                map({'o', 'x'}, 'ih', gitsigns.select_hunk)
            end,

            -- -- 键位映射配置函数
            -- on_attach = function(bufnr)
            --     local gs = package.loaded.gitsigns
            --
            --     -- 局部键位映射函数
            --     local function map(mode, l, r, opts)
            --         opts = opts or {}
            --         opts.buffer = bufnr
            --         vim.keymap.set(mode, l, r, opts)
            --     end
            --
            --     -- 导航
            --     map('n', ']c', function()
            --         if vim.wo.diff then return ']c' end
            --         vim.schedule(function() gs.next_hunk() end)
            --         return '<Ignore>'
            --     end, { expr = true, desc = "Next hunk" })
            --
            --     map('n', '[c', function()
            --         if vim.wo.diff then return '[c' end
            --         vim.schedule(function() gs.prev_hunk() end)
            --         return '<Ignore>'
            --     end, { expr = true, desc = "Prev hunk" })
            --
            --     -- 操作
            --     map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>', { desc = "Stage hunk" })
            --     map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>', { desc = "Reset hunk" })
            --
            --     map('n', '<leader>hS', gs.stage_buffer, { desc = "Stage buffer" })
            --     map('n', '<leader>hR', gs.reset_buffer, { desc = "Reset buffer" })
            --
            --     map('n', '<leader>hu', gs.undo_stage_hunk, { desc = "Undo stage hunk" })
            --     map('n', '<leader>hp', gs.preview_hunk, { desc = "Preview hunk" })
            --     map('n', '<leader>hb', function() gs.blame_line{full=true} end, { desc = "Blame line" })
            --     map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = "Toggle blame" })
            --     map('n', '<leader>hd', gs.diffthis, { desc = "Diff this" })
            --     map('n', '<leader>hD', function() gs.diffthis('~') end, { desc = "Diff this ~" })
            --     map('n', '<leader>td', gs.toggle_deleted, { desc = "Toggle deleted" })
            --
            --     -- 文本对象
            --     map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { desc = "Select hunk" })
            -- end,
        },
    },
}

