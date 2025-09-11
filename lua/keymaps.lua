
-- leader key 为空
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local function map(mode, lhs, rhs, opts)
    local options = {noremap = true, silent = true}

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

map("i", "jk",          "<ESC>",        {desc = ""})

map("n", "qq",          ":q!<CR>",      {desc = ""})
map("n", "<leader>q",   ":qa!<CR>",     {desc = ""})

-- alt + hjkl  窗口之间跳转
map("n", "<A-h>",       "<C-w>h",       {desc = ""})
map("n", "<A-j>",       "<C-w>j",       {desc = ""})
map("n", "<A-k>",       "<C-w>k",       {desc = ""})
map("n", "<A-l>",       "<C-w>l",       {desc = ""})


vim.cmd([[
    nnoremap ; :
    :command W w
    :command WQ wq
    :command Wq wq
    :command Q q
    :command Qa qa
    :command QA qa
]])

