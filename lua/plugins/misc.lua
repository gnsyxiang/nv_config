
return {
    {
        "gcmt/wildfire.vim",
        event = "VeryLazy",
        init = function()
            vim.g.wildfire_objects = {
                -- 引号类
                "i'", 'i"', "i`",

                -- 括号类
                "i)", "i]", "i>", "i}",

                -- 标记类
                "it",       -- 标签内的内容
                "ip",       -- 段落

                -- 单词和句子
                -- "iw",  -- 单词内部
                -- "is",  -- 句子内部
            }
        end,
    },
}

