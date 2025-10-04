
local M = {}

function M.setup(lspconfig, on_attach, capabilities)
    lspconfig.lua_ls.setup{
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
                diagnostics = {
                    -- 忽略掉vim配置时一些全局变量语言服务器找不到的警告
                    globals = {
                        "vim",
                        "require",
                        "opts",
                    },
                },
                runtime = {
                    version = 'LuaJIT',
                },
                workspace = {
                    library = {
                        [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                        [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                        [vim.fn.expand("~/.config/nvim/lua")] = true,
                    },
                    maxPreload = 10000,
                    preloadFileSize = 10000,
                    checkThirdParty = false
                },
                telemetry = {
                    enable = false
                },
            }
        }
    }
end

return M

