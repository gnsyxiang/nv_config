
return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",                        -- 首次安装后自动更新语法解析器
        config = function()
            local status, treesitter_config = pcall(require, "nvim-treesitter.configs") -- 确保nvim-treesitter安装
            if not status then
                vim.notify("没有找到 nvim-treesitter")
                return
            end

            local treesitter_parsers = require("nvim-treesitter.parsers")
            local treesitter_install = require("nvim-treesitter.install")

            local install_path = vim.fn.stdpath("data") .. "/treesitter_parsers"        -- 自定义解析器的安装路径
            vim.fn.mkdir(install_path, "p")                                             -- 创建目录
            vim.opt.runtimepath:append(install_path)                                    -- 将目录添加到运行时路径

            local parsers_config = treesitter_parsers.get_parser_configs()              -- 获取所有解析器配置
            for _, config in pairs(parsers_config) do                                   -- 为所有解析器设置 SSH URL
                if config.install_info and config.install_info.url then
                    local url = config.install_info.url

                    if url:find("https://github.com/") then
                        config.install_info.url = url:gsub("https://github.com/", "git@github.com:")
                    elseif url:find("https://gitlab.com/") then
                        -- config.install_info.url = url:gsub("https://gitlab.com/", "git@gitlab.com:")
                    end
                end
            end

            treesitter_install.prefer_git = true                -- 使用git下载

            treesitter_config.setup({
                parser_install_dir = install_path,              -- 指定解析器安装目录

                sync_install = false,                           -- 异步安装

                auto_install = true,                            -- 自动安装语言解析器
                ensure_installed = {                            -- 确保安装的语言解析器
                    "c", "cpp",  "c_sharp", "asm", "nasm", "objdump",
                    "bash", "vim", "vimdoc",
                    "json", "json5", "jsonc", "jsonnet", "hjson",
                    "markdown", "markdown_inline",
                    "toml", "yaml", "csv", "ini", "xml",
                    "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
                    "lua", "python",
                    "cmake", "make", "ninja",
                    "proto", "sql", "query",
                    -- "css", "html", "dockerfile", "go",
                    -- "java", "regex", "rust", "tsx",
                    -- "typescript", "javascript",
                },

                ignore_install = {                              -- 明确不安装的解释器
                    "rust"
                },

                highlight = {                                   -- 启用高亮功能
                    enable = true,
                    disable = function(lang, buf)
                        -- 首先检查是否在禁用列表中
                        local disabled_languages = { "rust" }
                        for _, disabled_lang in ipairs(disabled_languages) do
                            if lang == disabled_lang then
                                return true
                            end
                        end

                        -- 然后检查文件大小
                        local max_filesize = 100 * 1024 -- 100 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end

                        return false
                    end,

                    additional_vim_regex_highlighting = false,  -- 如果设置为 true，会同时使用 Tree-sitter 和传统的正则表达式高亮
                },

                incremental_selection = {                       -- 启用增量选择
                    enable = true,
                    keymaps = {
                        init_selection      = "gnn",            -- 进入增量选择模式
                        node_incremental    = "grn",            -- 向外扩展选区
                        node_decremental    = "grm",            -- 向内缩小选区
                        scope_incremental   = "grc",            -- 切换整个函数/作用域的选择
                    },
                },

                indent = {
                    enable = true,                              -- 启用基于 treesitter 的代码缩进
                },

                -- 文本对象
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                        },
                    },
                },

                -- 启用基于 treesitter 的代码折叠
                -- 注意：请将 zR、zM 等折叠命令改为 zv、zM 等，或设置 `foldmethod=expr` 和 `foldexpr=nvim_treesitter#foldexpr()`
                -- 更多信息见 :h nvim-treesitter-folding
                fold = {
                    enable = true,
                    disable = { "md" },             -- （可选）对某些语言禁用折叠，例如 markdown
                    fold_virt_text = true,          -- 在折叠闭合处显示虚拟文本（通常是折叠内容的开头）
                    max_fold_lines = 1000,          -- 如果超过这个行数，则禁用折叠, 针对大文件禁用折叠（可选，用于性能优化）

                    -- 非常重要的配置：设置默认折叠级别
                    -- 注意：这个选项和上面的 `vim.opt.foldlevel` 功能类似，但属于插件层。
                    -- 如果设置了它，可能会覆盖 `vim.opt.foldlevel` 的效果。
                    -- 通常建议只使用其中一个。Treesitter 文档推荐使用 `vim.opt.foldlevel`。
                    -- fold_level = 0, -- 0 是最高折叠级别（折叠所有），99 是最低（几乎不折叠）。不推荐在此设置。
                },
            })

            vim.opt.foldmethod = "expr"
            vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
            -- vim.opt.foldcolumn = "1"     -- 显示折叠栏，提供视觉反馈
            vim.opt.foldlevel = 99       -- 打开文件时默认不折叠
            vim.opt.foldlevelstart = 99  -- 同上
            -- vim.opt.foldminlines = 1  -- 至少需要多少行才能折叠（默认 1），可以设置为 3 来避免小折叠

            -- zc：折叠光标下的代码
            -- zo：展开光标下的代码
            -- za：切换光标下的折叠状态

            -- zR：展开所有折叠 (foldlevel=99)
            -- zM：折叠所有可折叠的代码 (foldlevel=0)
            -- zC / zO: 递归地折叠/展开某一层级
        end,
    },
}

-- -- 可选：为 C/C++ 设置特定的折叠行为
-- -- 例如，默认打开文件时不折叠，可以设置一个自动命令
-- vim.api.nvim_create_autocmd({ "BufEnter" }, {
--     pattern = { "*.c", "*.cpp", "*.h", "*.hpp" },
--     callback = function()
--         -- 设置折叠级别为 99（几乎不折叠），但保留折叠功能
--         vim.opt.foldlevel = 99
--     end,
-- })
