
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local function keymap(mode, lhs, rhs, opts)
    local options ={noremap = true, silent = true}

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, lhs, rhs, options)
end

keymap("i", "jk",       "<ESC>",        {desc = ""})

-- 多窗口的打开和关闭
keymap("n", "s",        "",             {desc = ""})    -- 取消 s 默认功能
keymap("n", "sv",       ":vsp<CR>",     {desc = ""})
keymap("n", "sh",       ":sp<CR>",      {desc = ""})
keymap("n", "sc",       "<C-W>c",       {desc = ""})
keymap("n", "so",       "<C-W>o",       {desc = ""})

-- 窗口之间的跳转
keymap("n", "<A-h>",    "<C-w>h",       {desc = ""})
keymap("n", "<A-j>",    "<C-w>j",       {desc = ""})
keymap("n", "<A-k>",    "<C-w>k",       {desc = ""})
keymap("n", "<A-l>",    "<C-w>l",       {desc = ""})

vim.cmd([[
    nnoremap ; :
    :command W w
    :command WQ wq
    :command Wq wq
    :command Q q
    :command Qa qa
    :command QA qa
]])

