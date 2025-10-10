
return {
    {
        'nvim-telescope/telescope.nvim',
        branch = '0.1.x',
        dependencies = {
            'nvim-lua/plenary.nvim',
            'nvim-tree/nvim-web-devicons',  -- 可选，用于图标
        },
        config = function()
            local telescope = require('telescope')
            local actions = require('telescope.actions')

            telescope.setup({
                defaults = {
                    layout_strategy = "horizontal",
                    layout_config = {
                        horizontal = {
                            width = 0.8,            -- 窗口宽度占屏幕的90%
                            height = 0.8,           -- 窗口高度占屏幕的95%
                            preview_width = 0.6,    -- 预览区域宽度占比
                            mirror = false,         -- 不镜像布局（预览在右侧）
                        },
                    },
                    prompt_prefix = "🔍 ",
                    selection_caret = " ",
                    path_display = { "smart" },
                    file_ignore_patterns = {
                        ".git/", ".cache", "node_modules/", "build/", "target/",
                        "%.o", "%.a", "%.out", "%.class", "%.pdf", "%.mkv", "%.mp4", "%.zip",
                    },

                    mappings = {
                        i = {
                            ["<C-n>"]   = actions.cycle_history_next,
                            ["<C-p>"]   = actions.cycle_history_prev,
                            ["<C-j>"]   = actions.move_selection_next,
                            ["<C-k>"]   = actions.move_selection_previous,
                            ["<C-c>"]   = actions.close,
                            ["<Down>"]  = actions.move_selection_next,
                            ["<Up>"]    = actions.move_selection_previous,
                            ["<CR>"]    = actions.select_default,
                            ["<C-x>"]   = actions.select_horizontal,
                            ["<C-v>"]   = actions.select_vertical,
                            ["<C-t>"]   = actions.select_tab,
                            ["<C-u>"]   = actions.preview_scrolling_up,
                            ["<C-d>"]   = actions.preview_scrolling_down,
                        },
                        n = {
                            ["q"]       = actions.close,
                            ["o"]       = actions.select_default,
                            ["H"]       = actions.select_horizontal,
                            ["V"]       = actions.select_vertical,
                            ["j"]       = actions.move_selection_next,
                            ["k"]       = actions.move_selection_previous,
                            ["K"]       = actions.preview_scrolling_up,
                            ["J"]       = actions.preview_scrolling_down,
                            ["<C-t>"]   = actions.select_tab,
                            ["gg"]      = actions.move_to_top,
                            ["G"]       = actions.move_to_bottom,
                            -- ["<esc>"]   = actions.close,
                            -- ["<CR>"]    = actions.select_default,
                            -- ["<C-x>"]   = actions.select_horizontal,
                            -- ["<C-v>"]   = actions.select_vertical,
                            -- ["<C-t>"]   = actions.select_tab,
                            -- ["j"]       = actions.move_selection_next,
                            -- ["k"]       = actions.move_selection_previous,
                            -- ["H"]       = actions.move_to_top,
                            -- ["M"]       = actions.move_to_middle,
                            -- ["L"]       = actions.move_to_bottom,
                            -- ["<Down>"]  = actions.move_selection_next,
                            -- ["<Up>"]    = actions.move_selection_previous,
                            -- ["gg"]      = actions.move_to_top,
                            -- ["G"]       = actions.move_to_bottom,
                            -- ["<C-u>"]   = actions.preview_scrolling_up,
                            -- ["<C-d>"]   = actions.preview_scrolling_down,
                        },
                    },
                },
                extensions = {
                    -- 未来可以在这里添加扩展配置
                },
            })

            -- 启用 telescope fzf 扩展（如果安装了）
            pcall(telescope.load_extension, 'fzf')

            -- 设置快捷键
            local builtin = require('telescope.builtin')

            -- 文件相关
            vim.keymap.set('n', '<leader>ff', builtin.find_files,                   { desc = 'Find files' })
            vim.keymap.set('n', '<leader>fg', builtin.live_grep,                    { desc = 'Live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers,                      { desc = 'Find buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags,                    { desc = 'Help tags' })
            vim.keymap.set('n', '<leader>fo', builtin.oldfiles,                     { desc = 'Recent files' })
            vim.keymap.set('n', '<leader>fz', builtin.current_buffer_fuzzy_find,    { desc = 'Fuzzy find in current buffer' })

            -- Git 相关
            -- vim.keymap.set('n', '<leader>gc', builtin.git_commits, { desc = 'Git commits' })
            -- vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = 'Git branches' })
            -- vim.keymap.set('n', '<leader>gs', builtin.git_status, { desc = 'Git status' })

            -- 其他
            vim.keymap.set('n', '<leader>km', builtin.keymaps, { desc = 'Keymaps' })
            vim.keymap.set('n', '<leader>cs', builtin.colorscheme, { desc = 'Colorscheme' })
        end,
    },

    -- 可选：安装 fzf 扩展以获得更好的性能
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
        cond = vim.fn.executable 'make' == 1,
        config = function()
            require('telescope').load_extension('fzf')
        end,
    },
}

