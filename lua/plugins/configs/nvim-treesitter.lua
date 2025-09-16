
-- 指定自定义的解析器安装路径
local install_path = vim.fn.stdpath("data") .. "/treesitter_parsers"

-- 确保目录存在
vim.fn.mkdir(install_path, "p")

-- 将自定义解析器目录添加到运行时路径
vim.opt.runtimepath:append(install_path)

-- 获取所有解析器配置
local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

-- 为所有解析器设置 SSH URL
for _, config in pairs(parser_config) do
    if config.install_info and config.install_info.url then
        -- 将 HTTPS URL 转换为 SSH URL
        local url = config.install_info.url

        if url:find("https://github.com/") then
            config.install_info.url = url:gsub("https://github.com/", "git@github.com:")
        elseif url:find("https://gitlab.com/") then
            -- config.install_info.url = url:gsub("https://gitlab.com/", "git@gitlab.com:")
        end
    end
end

require("nvim-treesitter.install").prefer_git = true

require("nvim-treesitter.configs").setup({
    -- 指定解析器安装目录
    parser_install_dir = install_path,

    -- 启用高亮功能
    highlight = {
        enable = true,
        disable = {}, -- 禁用某些语言
        additional_vim_regex_highlighting = false,
    },

    -- 启用增量选择
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
        },
    },

    -- 启用缩进
    indent = {
        enable = true,
    },

    -- 确保安装的语言解析器
    ensure_installed = {
        "c", "cpp",  "c_sharp", "asm", "nasm", "objdump",
        "bash", "vim", "vimdoc",
        "json", "json5", "jsonc", "jsonnet", "hjson",
        "markdown", "markdown_inline",
        "toml", "yaml", "csv", "ini", "xml",
        "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
        "lua", "python",
        "cmake", "make", "ninja",
        "proto", "sql",
        -- "css", "html", "dockerfile", "go",
        -- "java", "regex", "rust", "tsx",
        -- "typescript", "javascript",
    },

    -- 自动安装语言解析器
    auto_install = true,

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
})

