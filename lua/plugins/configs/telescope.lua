
local telescope = require("telescope")
local actions = require("telescope.actions")

telescope.setup({
    defaults = {
        -- layout_strategy = "horizontal",
        -- layout_config = {
        --     width = 0.95,
        --     height = 0.85,
        --     preview_cutoff = 120,
        --     horizontal = {
        --         preview_width = 0.6
        --     },
        -- },
        mappings = {
            i = {
                ["<C-k>"] = actions.move_selection_previous,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
                ["<ESC>"] = actions.close,
            },
        },
        file_ignore_patterns = {
            ".git", ".cache", "node_modules", "target", "build",
            "%.o", "%.a", "%.out", "%.class",
            "%.pdf", "%.mkv", "%.mp4", "%.zip",
        },
    },
    extensions = {
        fzf = {                                            -- 启用fzf扩展（如果安装了）
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        }
    }
    -- pickers = {
    --     find_files = {
    --         theme = "dropdown",
    --         hidden = true,
    --         previewer = false,
    --     },
    --     live_grep = {
    --         theme = "dropdown",
    --     },
    --     buffers = {
    --         theme = "dropdown",
    --         previewer = false,
    --     },
    -- },
})

-- 加载扩展
pcall(telescope.load_extension, "fzf")
-- pcall(telescope.load_extension, "ui-select")
-- pcall(telescope.load_extension, "undo")

-- 设置快捷键
local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
vim.keymap.set("n", "<leader>fr", builtin.oldfiles, { desc = "Recent Files" })
vim.keymap.set("n", "<leader>fc", builtin.git_commits, { desc = "Git Commits" })
vim.keymap.set("n", "<leader>fs", builtin.git_status, { desc = "Git Status" })
vim.keymap.set("n", "<leader>fk", builtin.keymaps, { desc = "Keymaps" })

