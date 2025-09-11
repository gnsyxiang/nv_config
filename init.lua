
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "git@github.com:folke/lazy.nvim.git"
  local out = vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      "--branch=v11.17.1",
      lazyrepo,
      lazypath
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.rtp:prepend(lazypath)

-- 加载核心配置
require("options")   -- 基础选项设置
require("keymaps")   -- 按键映射

-- 设置 lazy.nvim 并指定插件规格
require("lazy").setup({
  -- 导入所有插件模块
  spec = {
    { import = "plugins" },      -- 基础插件

    -- { import = "setup.plugins.ui" },    -- UI 相关插件
    -- { import = "setup.plugins.coding" }, -- 编程辅助插件
    -- 可以根据需要注释或取消注释下面的行
    -- { import = "setup.plugins.lang.lua" },
    -- { import = "setup.plugins.lang.python" },
    -- { import = "setup.plugins.lang.rust" },
  },
  -- 全局 lazy.nvim 配置
  install = { 
    colorscheme = { "gruvbox", "default" } 
  },
  checker = { 
    enabled = true, 
    frequency = 3600, -- 每小时检查一次更新
    notify = false    -- 不通知可用更新
  },
  performance = {
    rtp = {
      -- 禁用一些可能不需要的运行时路径
      disabled_plugins = {
        "2html_plugin",
        "tohtml",
        "getscript",
        "getscriptPlugin",
        "gzip",
        "logipat",
        "netrw",
        "netrwPlugin",
        "netrwSettings",
        "netrwFileHandlers",
        "matchit",
        "tar",
        "tarPlugin",
        "rrhelper",
        "spellfile_plugin",
        "vimball",
        "vimballPlugin",
        "zip",
        "zipPlugin",
        "tutor",
        "rplugin",
        "syntax",
        "synmenu",
        "optwin",
        "compiler",
        "bugreport",
        "ftplugin",
      },
    },
  },
})

vim.cmd("colorscheme gruvbox")

