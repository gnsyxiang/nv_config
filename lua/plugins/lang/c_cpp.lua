
local M = {}

function M.setup(lspconfig, on_attach, capabilities)
    lspconfig.clangd.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=never",
            "--completion-style=detailed",
            "--query-driver=/usr/bin/g++,/usr/bin/clang++",
            "--all-scopes-completion",        -- 全局代码补全
            "--cross-file-rename",            -- 跨文件重命名
            "--completion-style=bundled",     -- 补全样式
        },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        root_dir = lspconfig.util.root_pattern(
            "compile_commands.json",  -- 优先使用 compile_commands.json
            "compile_flags.txt",
            ".git",
            "CMakeLists.txt",
            "Makefile"
        ),
    }
end

return M

