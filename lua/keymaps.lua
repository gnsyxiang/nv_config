
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

-- 多窗口的打开与关闭
map("n", "s",           "",             {desc = ""})    -- 取消 s 默认功能
map("n", "sv",          ":vsp<CR>",     {desc = ""})
map("n", "sh",          ":sp<CR>",      {desc = ""})
map("n", "sc",          "<C-w>c",       {desc = ""})
map("n", "so",          "<C-w>o",       {desc = ""})

-- alt + hjkl  窗口之间跳转
map("n", "<A-h>",       "<C-w>h",       {desc = ""})
map("n", "<A-j>",       "<C-w>j",       {desc = ""})
map("n", "<A-k>",       "<C-w>k",       {desc = ""})
map("n", "<A-l>",       "<C-w>l",       {desc = ""})

-- 左右比例控制
map("n", "s,",          ":vertical resize -10<CR>", {desc = ""})
map("n", "s.",          ":vertical resize +10<CR>", {desc = ""})
map("n", "<C-Left>",    ":vertical resize -2<CR>",  {desc = ""})
map("n", "<C-Right>",   ":vertical resize +2<CR>",  {desc = ""})
-- 上下比例
map("n", "sj",          ":resize +10<CR>",          {desc = ""})
map("n", "sk",          ":resize -10<CR>",          {desc = ""})
map("n", "<C-Down>",    ":resize +2<CR>",           {desc = ""})
map("n", "<C-Up>",      ":resize -2<CR>",           {desc = ""})
-- 相等比例
map("n", "s=", "<C-w>=", opts)

vim.cmd([[
    nnoremap ; :
    :command W w
    :command WQ wq
    :command Wq wq
    :command Q q
    :command Qa qa
    :command QA qa
]])

vim.cmd([[
        function AddCTitle()
        call append( 0, "/**")
        call append( 1, " * ")
        call append( 2, " * Release under GPLv-3.0.")
        call append( 3, " * ")
        call append( 4, " * @file    ".expand("%:t"))		            " %表示绝对路径，%:h表示目录，%:t表示文件名
        call append( 5, " * @brief   ")	                                " append表示追加
        call append( 6, " * @author  gnsyxiang <gnsyxiang@163.com>")
        call append( 7, " * @date    ".strftime("%d/%m %Y %H:%M"))
        call append( 8, " * @version v0.0.1")
        call append( 9, " * ")
        call append(10, " * @since    note")
        call append(11, " * @note     note")
        call append(12, " * ")
        call append(13, " *     change log:")
        call append(14, " *     NO.     Author              Date            Modified")
        call append(15, " *     00      zhenquan.qiu        ".strftime("%d/%m %Y")."      create the file")
        call append(16, " * ")
        call append(17, " *     last modified: ".strftime("%d/%m %Y %H:%M"))
        call append(18, " */")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
    endf

    function AddHTitle()
        call append( 0, "/**")
        call append( 1, " *")
        call append( 2, " * Release under GPLv-3.0.")
        call append( 3, " * ")
        call append( 4, " * @file    ".expand("%:t"))		            " %表示绝对路径，%:h表示目录，%:t表示文件名
        call append( 5, " * @brief   ")	                                " append表示追加
        call append( 6, " * @author  gnsyxiang <gnsyxiang@163.com>")
        call append( 7, " * @date    ".strftime("%d/%m %Y %H:%M"))
        call append( 8, " * @version v0.0.1")
        call append( 9, " * ")
        call append(10, " * @since    note")
        call append(11, " * @note     note")
        call append(12, " * ")
        call append(13, " *     change log:")
        call append(14, " *     NO.     Author              Date            Modified")
        call append(15, " *     00      zhenquan.qiu        ".strftime("%d/%m %Y")."      create the file")
        call append(16, " * ")
        call append(17, " *     last modified: ".strftime("%d/%m %Y %H:%M"))
        call append(18, " */")
        call append(19, "#ifndef __")
        call append(20, "#define ")
        call append(21, "")
        call append(22, "#ifdef __cplusplus")
        call append(23, "extern \"C\" {")
        call append(24, "#endif")
        call append(25, "")
        call append(26, "#ifdef __cplusplus")
        call append(27, "}")
        call append(28, "#endif")
        call append(29, "")
        call append(30, "#endif")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
    endf

    function AddTitle()
        call append( 0, "# ===============================================================")
        call append( 1, "# ")
        call append( 2, "# Release under GPLv-3.0.")
        call append( 3, "# ")
        call append( 4, "# @file    ".expand("%:t"))		            " %表示绝对路径，%:h表示目录，%:t表示文件名
        call append( 5, "# @brief   ")	                                " append表示追加
        call append( 6, "# @author  gnsyxiang <gnsyxiang@163.com>")
        call append( 7, "# @date    ".strftime("%d/%m %Y %H:%M"))
        call append( 8, "# @version v0.0.1")
        call append( 9, "# ")
        call append(10, "# @since    note")
        call append(11, "# @note     note")
        call append(12, "# ")
        call append(13, "#     change log:")
        call append(14, "#     NO.     Author              Date            Modified")
        call append(15, "#     00      zhenquan.qiu        ".strftime("%d/%m %Y")."      create the file")
        call append(16, "# ")
        call append(17, "#     last modified: ".strftime("%d/%m %Y %H:%M"))
        call append(18, "# ===============================================================")
        echohl WarningMsg | echo "Successful in adding the copyright." | echohl None
    endf

    "更新最近修改时间和文件名
    function UpdateTitle()
        normal m'
        execute '/# *Last modified:/s@:.*$@\=strftime(": %d/%m %Y %H:%M")@'
        normal ''
        normal mk
        execute '/# *Filename:/s@:.*$@\=": ".expand("%:t")@'
        execute "noh"
        normal 'k
        echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
    endfunction

    "判断前10行代码里面，是否有Last modified这个单词，
    "如果没有的话，代表没有添加过作者信息，需要新添加；
    "如果有的话，那么只需要更新即可
    function TitleDet()
        let n=1
        "默认为添加
        while n < 10
            let line = getline(n)
            if line =~ '^\#\s*\S*last\smodified:\S*.*$'
                call UpdateTitle()
                return
            endif
            let n = n + 1
        endwhile
        call AddTitle()
    endfunction
]])

