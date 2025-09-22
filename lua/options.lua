
local indent = {
    -- 1，开启基础自动缩进
    autoindent = true,

    -- 2. 明确关闭旧式的、可能产生冲突的智能缩进
    smartindent = false,        -- smartindent 是一个过时的、功能有限的选项，你应该避免使用它
    cindent = false,            -- 是一个非常强大但专门化的工具，仅在你进行 C/C++ 开发且对风格有极致要求时考虑使用。

    -- 3. 设置通用的缩进格式（空格、宽度）
    tabstop = 4,                -- 每个Tab显示为4个空格宽度
    shiftwidth = 4,             -- 每次缩进使用4个空格
    softtabstop = 4,            -- 编辑时Tab键插入4个空格
    expandtab = true,           -- 将Tab转换为空格
    shiftround = true,          -- 启用缩进对齐到shiftwidth的倍数

    -- -- 4. [可选] 如果你主要做C开发，可以仅为c文件类型开启cindent
    -- vim.api.nvim_create_autocmd("FileType", {
    --   pattern = { "c", "h" },
    --   callback = function()
    --     vim.opt_local.cindent = true
    --     -- 可以在这里配置 cinoptions
    --   end,
    -- })

    -- 5. [推荐] 安装并配置 nvim-treesitter 来获得最好的缩进体验
}

vim.opt.shortmess:append 'c'
for k, v in pairs(indent) do
    vim.opt[k] = v
end

local options = {
    -- 用于指定打开文件的编码方式
    -- 用于指定Vim内部字符处理的编码方式
    fileencoding = 'utf-8',
    encoding = "utf-8",
    -- termencoding = "utf-8",

    -- 开启语法高亮
    syntax = "off",

    number = true,              -- 显示行号
    relativenumber = true,      -- 显示相对行号


    -- unnamed：这是默认值，表示将文本复制到系统剪贴板（如果支持）以及Vim的寄存器中。
    -- unnamedplus：这个选项会将文本同时复制到系统剪贴板以及Vim的寄存器中。这样，你可以在Vim和其他应用程序之间共享剪贴板内容。
    -- autoselect：这个选项会将文本复制到系统剪贴板中，但不会存储在Vim的寄存器中。
    --clipboard = 'unnamedplus',

    -- 高亮当前行
    -- 不高亮当前列
    -- 右侧参考线
    cursorline = true,
    cursorcolumn = true,
    colorcolumn = "80",

    -- 显示光标位置
    ruler = true,

    --查找时忽略大小写
    --智能大小写
    ignorecase = true,
    smartcase = true,

    -- 搜索不要高亮
    -- 边输入边搜索
    hlsearch = true,
    incsearch = true,

    -- 显示左侧图标指示列
    signcolumn = "yes",

    -- 命令行高为2，提供足够的显示空间
    cmdheight = 1,

    -- 当文件被外部程序修改时，自动加载
    autoread = true,

    -- 禁止自动换行
    wrap = false,

    -- 允许隐藏被修改过的buffer
    hidden = true,

    --右下角显示模式
    showmode = true,
    conceallevel = 0,

    --如果安装第三方主题，必须设置为true
    termguicolors = true,

    -- 是否显示不可见字符
    -- 不可见字符的显示，这里只把空格显示为一个点
    list = true,
    --listchars = "space:·,tab:··",

    --允许鼠标
    mouse = 'a',

    -- jkhl 移动时光标周围保留8行
    scrolloff = 8,
    sidescrolloff = 8,

    -- 0：不显示标签栏。这意味着在Vim窗口的底部不会显示任何文件标签。
    -- 1：只有在打开了多个文件时才显示标签栏。当只有一个文件打开时，标签栏会被隐藏。
    -- 2：无论是否只有一个文件打开，都显示标签栏。
    showtabline = 2,

    -- 禁止创建备份文件
    backup = false,
    writebackup = false,
    swapfile = false,

    --右下角显示命令
    showcmd = true,
}
--这里只列举基础的配置，更多选项可以在Vim中:set all查询

--应用上面配置
vim.opt.shortmess:append 'c'
for k, v in pairs(options) do
    vim.opt[k] = v
end

vim.cmd([[
    set clipboard+=unnamed,unnamedplus
    " set clipboard+=unnamedplus
]])

vim.g.wildfire_objects = {
    "i'",  -- 单引号内的内容
    'i"',  -- 双引号内的内容
    "i)",  -- 圆括号内的内容
    "i]",  -- 方括号内的内容
    "i>",  -- 括号内的内容
    "i}",  -- 花括号内的内容
    "ip",  -- 段落
    "it"   -- 标签内的内容
}

-- 如果你希望特定文件类型使用不同设置
vim.api.nvim_create_autocmd("FileType", {
  pattern = "make",
  callback = function()
    vim.opt_local.tabstop = 8
    vim.opt_local.shiftwidth = 8
    vim.opt_local.softtabstop = 8
    vim.opt_local.expandtab = false -- Makefile需要真实的Tab
  end
})

-- autocmd BufNewFile, BufReadPost *.html setlocal nowrap

