
local mason             = require("mason")
local mason_lspconfig   = require("mason-lspconfig")
local lspconfig         = require("lspconfig")

mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

-- vim.keymap.set('n', '<leader>d',    vim.diagnostic.open_float,  { desc = "打开诊断信息" })
-- vim.keymap.set('n', '[d',           vim.diagnostic.goto_prev,   { desc = "上一个诊断" })
-- vim.keymap.set('n', ']d',           vim.diagnostic.goto_next,   { desc = "下一个诊断" })
-- vim.keymap.set('n', '<leader>q',    vim.diagnostic.setloclist,  { desc = "诊断列表" })

-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = function(ev)
--         local opts = { buffer = ev.buf }
--         vim.keymap.set('n', 'gD',           vim.lsp.buf.declaration,                opts,   { desc = "转到声明" })
--         vim.keymap.set('n', 'gd',           vim.lsp.buf.definition,                 opts,   { desc = "转到定义" })
--         vim.keymap.set('n', 'K',            vim.lsp.buf.hover,                      opts,   { desc = "悬停信息" })
--         vim.keymap.set('n', 'gi',           vim.lsp.buf.implementation,             opts,   { desc = "转到实现" })
--         vim.keymap.set('n', '<C-k>',        vim.lsp.buf.signature_help,             opts,   { desc = "签名帮助" })
--         vim.keymap.set('n', '<leader>wa',   vim.lsp.buf.add_workspace_folder,       opts,   { desc = "添加工作区文件夹" })
--         vim.keymap.set('n', '<leader>wr',   vim.lsp.buf.remove_workspace_folder,    opts,   { desc = "移除工作区文件夹" })
--         vim.keymap.set('n', '<leader>wl', function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end,                                                                        opts,   { desc = "列出工作区文件夹" })
--         vim.keymap.set('n', '<leader>D',    vim.lsp.buf.type_definition,            opts,   { desc = "类型定义" })
--         vim.keymap.set('n', '<leader>rn',   vim.lsp.buf.rename,                     opts,   { desc = "重命名" })
--         vim.keymap.set('n', 'gr',           vim.lsp.buf.references,                 opts,   { desc = "引用" })
--         vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,         opts,   { desc = "代码操作" })
--     end,
-- })

local capabilities = vim.lsp.protocol.make_client_capabilities()
local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
if status then
    capabilities = cmp_nvim_lsp.default_capabilities()
end

local install_servers = {
    "lua_ls",        -- Lua
    -- "pyright",       -- Python
    -- "rust_analyzer", -- Rust
    -- "ts_ls",         -- TypeScript/JavaScript
    -- "gopls",         -- Go
    "clangd",        -- C/C++
    -- "bashls",        -- Bash
    -- "jsonls",        -- JSON
    -- "yamlls",        -- YAML
}

for _, lsp in ipairs(install_servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end

mason_lspconfig.setup({
    ensure_installed = install_servers,
    automatic_installation = true,
})

-- lspconfig.clangd.setup({
--     capabilities = capabilities,
--     cmd = {
--         "clangd",
--         "--background-index",           -- 在后台构建索引并持久化
--         "--clang-tidy",                 -- 启用clang-tidy静态分析
--         "--suggest-missing-includes",   -- 
--         "--header-insertion=iwyu",
--     },
-- })
--
-- mason_lspconfig.setup({
--     ensure_installed = {"clangd"},
--     automatic_installation = true,
-- })

-- -- 设置诊断符号
-- local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
-- for type, icon in pairs(signs) do
--     local hl = "DiagnosticSign" .. type
--     vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end
--
-- -- 诊断配置
-- vim.diagnostic.config({
--     virtual_text = {
--         source = "always",
--     },
--     float = {
--         source = "always",
--     },
--     signs = true,
--     underline = true,
--     update_in_insert = false,
--     severity_sort = true,
-- })

-- vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = function(ev)
--         local opts = { buffer = ev.buf }
--         vim.keymap.set('n', 'gD',           vim.lsp.buf.declaration,                opts,   { desc = "转到声明" })
--         vim.keymap.set('n', 'gd',           vim.lsp.buf.definition,                 opts,   { desc = "转到定义" })
--         vim.keymap.set('n', 'K',            vim.lsp.buf.hover,                      opts,   { desc = "悬停信息" })
--         vim.keymap.set('n', 'gi',           vim.lsp.buf.implementation,             opts,   { desc = "转到实现" })
--         vim.keymap.set('n', '<C-k>',        vim.lsp.buf.signature_help,             opts,   { desc = "签名帮助" })
--         vim.keymap.set('n', '<leader>wa',   vim.lsp.buf.add_workspace_folder,       opts,   { desc = "添加工作区文件夹" })
--         vim.keymap.set('n', '<leader>wr',   vim.lsp.buf.remove_workspace_folder,    opts,   { desc = "移除工作区文件夹" })
--         vim.keymap.set('n', '<leader>wl', function()
--             print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
--         end,                                                                        opts,   { desc = "列出工作区文件夹" })
--         vim.keymap.set('n', '<leader>D',    vim.lsp.buf.type_definition,            opts,   { desc = "类型定义" })
--         vim.keymap.set('n', '<leader>rn',   vim.lsp.buf.rename,                     opts,   { desc = "重命名" })
--         vim.keymap.set('n', 'gr',           vim.lsp.buf.references,                 opts,   { desc = "引用" })
--         vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action,         opts,   { desc = "代码操作" })
--     end,
-- })
