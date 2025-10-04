
return {
    "neovim/nvim-lspconfig",
    tag = "v2.3.0",
    event = {"BufReadPre", "BufNewFile"},
    dependencies = {
        { "mason-org/mason.nvim", },
        { "mason-org/mason-lspconfig.nvim", tag = "v1.32.0", },
    },
    config = function()
        -- 通过mason来安装、管理语言服务器等
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗"
                }
            }
        })

        -- 通过mason-lspconfig来自动安装语言服务器并启用
        require("mason-lspconfig").setup({
            ensure_installed = {
                "clangd",        -- C/C++
                "lua_ls",        -- Lua
                "pyright",       -- Python

                -- "rust_analyzer", -- Rust
                -- "ts_ls",         -- TypeScript/JavaScript
                -- "bashls",        -- Bash
                -- "jsonls",        -- JSON
                -- "yamlls",        -- YAML

                -- "gopls",         -- Go
            },

            automatic_installation = true,
            automatic_enable = {
                exclude = {},
            },
        })

        -- 诊断信息的图标
        vim.diagnostic.config({
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "✘",
                    [vim.diagnostic.severity.WARN] = "▲",
                    [vim.diagnostic.severity.HINT] = "⚑",
                    [vim.diagnostic.severity.INFO] = "»",
                },
            },
        })

        local common        = require("plugins.lang.common")
        local capabilities  = common.get_capabilities()
        local on_attach     = common.on_attach
        local lspconfig     = require("lspconfig")

        require("plugins.lang.lua").setup(lspconfig, on_attach, capabilities)
        require("plugins.lang.c_cpp").setup(lspconfig, on_attach, capabilities)
    end,
}

