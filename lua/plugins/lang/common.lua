
local M = {}

-- 获取 capabilities 的函数
function M.get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local status, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
    if status then
        capabilities = cmp_nvim_lsp.default_capabilities()
    end
    return capabilities
end

function M.on_attach(client, bufnr)
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }

    -- 跳转到声明
    vim.keymap.set('n', 'gd', "<cmd>Lspsaga peek_definition<CR>", bufopts)
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gr', "<cmd>Lspsaga rename<CR>", bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gh', "<cmd>Lspsaga finder<CR>", bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<leader>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)

    -- 以浮窗形式显示错误
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", bufopts)
    vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", bufopts)
    vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", bufopts)
    vim.keymap.set('n', '<leader>q', "<cmd>lua vim.diagnostic.setloclist()<CR>", bufopts)

    vim.keymap.set('n', '<leader>cf', "<cmd>Lspsaga show_buf_diagnostics<CR>", bufopts)
    vim.keymap.set('n', '<leader>cd', "<cmd>Lspsaga show_workspace_diagnostics<CR>", bufopts)
    vim.keymap.set('n', '<leader>ca', "<cmd>Lspsaga code_action<CR>", bufopts)
    vim.keymap.set('v', '<leader>ca', "<cmd>Lspsaga code_action<CR>", bufopts)

    vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<leader>f', function() vim.lsp.buf.format { async = true } end, bufopts)
end

return M

