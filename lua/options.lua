
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
    termguicolors = true,                   -- 显示真彩色

    clipboard = "unnamed,unnamedplus",      -- vim和系统剪贴板关联

    number = true,                          -- 显示行号
    relativenumber = true,                  -- 显示相对行号

    cursorline = true,                      -- 高亮当前行
    cursorcolumn = true,                    -- 高亮当前列
    colorcolumn = "80",                     -- 80列高亮

    ignorecase = true,                      -- 查找时忽略大小写
    smartcase = true,                       -- 智能大小写

    hlsearch = true,                        -- 搜索高亮
    incsearch = true,                       -- 边输入边搜索

    wrap = false,                           -- 禁止自动换行
}

for k, v in pairs(options) do
    vim.opt[k] = v
end

