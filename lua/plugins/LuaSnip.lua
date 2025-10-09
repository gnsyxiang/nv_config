
return {
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load({
                -- paths = { vim.fn.stdpath("config") .. "/snippets" }
                paths = { "./snippets" }
            })

            -- 加载友好片段
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}

