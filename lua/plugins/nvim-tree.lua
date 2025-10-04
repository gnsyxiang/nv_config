
return {
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        keys = {
            { "<A-n>", "<cmd>NvimTreeToggle<CR>", desc = "切换文件树" }
        },
        config = function()
            local function on_attach(bufnr)
                local api = require('nvim-tree.api')

                -- 辅助函数，用于设置映射选项
                local function opts(desc)
                    return {desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true}
                end

                -- 默认映射
                api.config.mappings.default_on_attach(bufnr)

                -- 自定义映射
                vim.keymap.set('n', 'h',        api.node.navigate.parent_close,     opts('Close Directory'))
                vim.keymap.set('n', 'l',        api.node.open.edit,                 opts('Open'))

                vim.keymap.set('n', 'V',        api.node.open.vertical,             opts('Open: Vertical Split'))
                vim.keymap.set('n', 'H',        api.node.open.horizontal,           opts('Open: Horizontal Split'))

                vim.keymap.set("n", "<C-h>",    api.tree.toggle_hidden_filter,      opts("Toggle Filter: Dotfiles"))
            end

            local opts = {
                on_attach = on_attach,
                filters = {
                    dotfiles = true,       -- 显示隐藏文件
                    custom = {"node_modules", "\\.cache", "^%.git$"}, -- 除了隐藏文件外，自定义过滤的文件或目录
                },
                git = {
                    enable = true,
                    ignore = true,
                    timeout = 500,
                },
                view = {
                    side = "left",
                    width = 30,
                    number = false,
                    relativenumber = false,
                    signcolumn = "yes",
                },
                renderer = {
                    group_empty = true, -- 折叠空文件夹
                    indent_markers = {
                        enable = true,   -- 显示缩进标记
                    },
                    icons = {
                        show = {
                            file = true,
                            folder = true,
                            folder_arrow = true,
                            git = true,
                        },
                        glyphs = {
                            default = "",
                            symlink = "",
                            folder = {
                                arrow_closed = "", -- 文件夹关闭时的箭头
                                arrow_open = "",   -- 文件夹打开时的箭头
                                default = "",
                                open = "",
                                empty = "",
                                empty_open = "",
                                symlink = "",
                                symlink_open = "",
                            },
                            git = {
                                unstaged = "",
                                staged = "S",
                                unmerged = "",
                                renamed = "➜",
                                untracked = "U",
                                deleted = "",
                                ignored = "◌",
                            },
                        },
                    },
                },
                actions = {
                    change_dir = {
                        global = true,   -- 切换工作目录到文件树根目录
                    },
                    open_file = {
                        resize_window = true, -- 打开文件时自动调整窗口大小
                        quit_on_open = false, -- 打开文件后不自动关闭文件树
                    },
                },
            }

            require("nvim-tree").setup(opts)

            -- disable netrw at the very start of your init.lua (strongly advised)
            vim.g.loaded_netrw = 1
            vim.g.loaded_netrwPlugin = 1

            -- set termguicolors to enable highlight groups
            vim.opt.termguicolors = true

            -- 自定义自动命令
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function(data)
                    -- 如果是目录，自动打开文件树
                    local directory = vim.fn.isdirectory(data.file) == 1
                    if not directory then
                        return
                    end
                    vim.cmd.cd(data.file)
                    require("nvim-tree.api").tree.open()
                end
            })
        end,
    },
}

-- 可选：自动关闭NVim当文件树是最后一个窗口
-- vim.api.nvim_create_autocmd("BufEnter", {
--     nested = true,
--     callback = function()
--         if #vim.api.nvim_list_wins() == 1 and vim.api.nvim_buf_get_name(0):match("NvimTree_") ~= nil then
--             vim.cmd("quit")
--         end
--     end
-- })

