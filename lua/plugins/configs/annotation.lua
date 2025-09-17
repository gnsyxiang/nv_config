
local opts = {
    enabled = true,
    input_after_comment = true, -- 在注释后自动跳转到输入位置
    snippet_engine = "luasnip",
    languages = {
        c = {
            template = {
                annotation_convention = "doxygen", -- 使用doxygen风格
                doxygen_custom = {
                    { nil, "/**" },
                    { nil, " * @brief $1" },
                    { nil, " *" },
                    { "parameters", " * @param %s $1" },
                    { "return_statement", " * @return $1" },
                    { "throws", " * @exception %s $1" },
                    { nil, " */" },
                }
            }
        },
        cpp = {
            template = {
                annotation_convention = "doxygen", -- 使用doxygen风格
                doxygen_custom = {
                    { nil, "/**" },
                    { nil, " * @brief $1" },
                    { nil, " *" },
                    { "parameters", " * @param %s $1" },
                    { "return_statement", " * @return $1" },
                    { "throws", " * @exception %s $1" },
                    { nil, " */" },
                }
            }
        },
        python = {
            template = {
                annotation_convention = "google" -- google, numpy, or rest
            }
        },
        javascript = {
            template = {
                annotation_convention = "jsdoc" -- jsdoc or tomdoc
            }
        },
        typescript = {
            template = {
                annotation_convention = "jsdoc"
            }
        },
        lua = {
            template = {
                annotation_convention = "ldoc"
            }
        },
    }
}

require("neogen").setup(opts)

vim.keymap.set("n", "<Leader>nf", ":lua require('neogen').generate()<CR>", { desc = "Generate function documentation" })   -- 生成函数文档
vim.keymap.set("n", "<Leader>ns", function() require("neogen").generate({ type = "struct" }) end, { desc = "Generate struct documentation" })   -- 生成结构体文档
vim.keymap.set("n", "<Leader>ne", function() require("neogen").generate({ type = "file" }) end, { desc = "Generate file header" })              -- 生成文件文档

vim.keymap.set("n", "<Leader>nc", function() require("neogen").generate({ type = "class" }) end, { desc = "Generate class documentation" })     -- 生成类文档
vim.keymap.set("n", "<Leader>nt", function() require("neogen").generate({ type = "type" }) end, { desc = "Generate type documentation" })       -- 生成类型文档

