
return {
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "Kaiser-Yang/blink-cmp-avante",
        },
        version = "*",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            cmdline = {
                keymap = {
                    -- 选择并接受预选择的第一个
                    ["<CR>"] = { "select_and_accept", "fallback" },
                },
                completion = {
                    -- 不预选第一个项目，选中后自动插入该项目文本
                    list = { selection = { preselect = false, auto_insert = true } },
                    -- 自动显示补全窗口，仅在输入命令时显示菜单，而搜索或使用其他输入菜单时则不显示
                    menu = {
                        auto_show = function(ctx)
                            return vim.fn.getcmdtype() == ":"
                            -- enable for inputs as well, with:
                            -- or vim.fn.getcmdtype() == '@'
                        end,
                    },
                    -- 不在当前行上显示所选项目的预览
                    ghost_text = { enabled = false },
                },
            },
            keymap = {
                preset = "none",
                ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
                -- fallback命令将运行下一个非闪烁键盘映射(回车键的默认换行等操作需要)
                ["<CR>"] = { "accept", "fallback" }, -- 更改成'select_and_accept'会选择第一项插入
                ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                ["<Tab>"] = { "select_next", "snippet_forward", "fallback" }, -- 同时存在补全列表和snippet时，补全列表选择优先级更高

                ["<C-b>"] = { "scroll_documentation_up", "fallback" },
                ["<C-f>"] = { "scroll_documentation_down", "fallback" },

                ["<C-e>"] = { "snippet_forward", "select_next", "fallback" }, -- 同时存在补全列表和snippet时，snippet跳转优先级更高
                ["<C-u>"] = { "snippet_backward", "select_prev", "fallback" },
            },
            completion = {
                -- 示例：使用'prefix'对于'foo_|_bar'单词将匹配'foo_'(光标前面的部分),使用'full'将匹配'foo__bar'(整个单词)
                keyword = { range = "full" },
                -- 选择补全项目时显示文档(0秒延迟)
                documentation = { auto_show = true, auto_show_delay_ms = 0 },
                -- 不预选第一个项目，选中后自动插入该项目文本
                list = { selection = { preselect = false, auto_insert = false } },
                -- 针对菜单的外观配置
                -- menu = {
                -- 	min_width = 15,
                -- 	max_height = 10,
                -- 	border = "single", -- Defaults to `vim.o.winborder` on nvim 0.11+
                -- },
            },
            -- 指定文件类型启用/禁用
            enabled = function()
                return not vim.tbl_contains({
                    -- "lua",
                    -- "markdown"
                }, vim.bo.filetype) and vim.bo.buftype ~= "prompt" and vim.b.completion ~= false
            end,

            appearance = {
                -- 将后备高亮组设置为 nvim-cmp 的高亮组
                -- 当您的主题不支持blink.cmp 时很有用
                -- 将在未来版本中删除
                use_nvim_cmp_as_default = true,
                -- 将“Nerd Font Mono”设置为“mono”，将“Nerd Font”设置为“normal”
                -- 调整间距以确保图标对齐
                nerd_font_variant = "mono",
            },

            -- 已定义启用的提供程序的默认列表，以便您可以扩展它
            sources = {
                default = {
                    "buffer",
                    "lsp",
                    "path",
                    "snippets",
                    "avante",
                },
                providers = {
                    -- score_offset设置优先级数字越大优先级越高
                    buffer = { score_offset = 5 },
                    path = { score_offset = 3 },
                    lsp = { score_offset = 2 },
                    snippets = { score_offset = 1 },
                    cmdline = {
                        min_keyword_length = function(ctx)
                            -- when typing a command, only show when the keyword is 3 characters or longer
                            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
                                return 3
                            end
                            return 0
                        end,
                    },
                    avante = {
                        module = "blink-cmp-avante",
                        name = "Avante",
                        opts = {
                            -- options for blink-cmp-avante
                        },
                    },
                },
            },
        },
        -- 由于“opts_extend”，您的配置中的其他位置无需重新定义它
        opts_extend = { "sources.default" },
    },
    -- {
    --     "saghen/blink.cmp",
    --     -- optional: provides snippets for the snippet source
    --     dependencies = {
    --         'rafamadriz/friendly-snippets',
    --         "nvim-tree/nvim-web-devicons",
    --         "onsails/lspkind.nvim",
    --         "fang2hou/blink-copilot",
    --         "folke/lazydev.nvim",
    --     },
    --
    --     -- use a release tag to download pre-built binaries
    --     version = "1.*",
    --     -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
    --     -- build = 'cargo build --release',
    --     -- If you use nix, you can build from source using latest nightly rust with:
    --     -- build = 'nix run .#build-plugin',
    --
    --     ---@module 'blink.cmp'
    --     ---@type blink.cmp.Config
    --     opts = {
    --         -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    --         -- 'super-tab' for mappings similar to vscode (tab to accept)
    --         -- 'enter' for enter to accept
    --         -- 'none' for no mappings
    --         --
    --         -- All presets have the following mappings:
    --         -- C-space: Open menu or open docs if already open
    --         -- C-n/C-p or Up/Down: Select next/previous item
    --         -- C-e: Hide menu
    --         -- C-k: Toggle signature help (if signature.enabled = true)
    --         --
    --         -- See :h blink-cmp-config-keymap for defining your own keymap
    --         -- stylua: ignore
    --         keymap = {
    --             -- If the command/function returns false or nil, the next command/function will be run.
    --             preset = "none",
    --             ["<A-j>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
    --             ["<A-k>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
    --             ["<C-n>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
    --             ["<C-p>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
    --
    --             ["<C-u>"] = { "scroll_documentation_up", "fallback" },
    --             ["<C-d>"] = { "scroll_documentation_down", "fallback" },
    --
    --             ["<Tab>"] = { function(cmp) return cmp.accept() end, "fallback", },
    --             ["<CR>"] = { function(cmp) return cmp.accept() end, "fallback", },
    --             -- Close current completion and insert a newline
    --             ["<S-CR>"] = { function(cmp) cmp.hide() return false end, "fallback", },
    --
    --             -- Show/Remove completion
    --             ["<A-/>"] = { function(cmp) if cmp.is_menu_visible() then return cmp.hide() else return cmp.show() end end, "fallback", },
    --
    --             ["<A-n>"] = { function(cmp) cmp.show({ providers = {"buffer"} }) end, },
    --             ["<A-p>"] = { function(cmp) cmp.show({ providers = {"buffer"} }) end, },
    --         },
    --
    --         appearance = {
    --             -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    --             -- Adjusts spacing to ensure icons are aligned
    --             nerd_font_variant = "normal",
    --         },
    --
    --         -- Default list of enabled providers defined so that you can extend it
    --         -- elsewhere in your config, without redefining it, due to `opts_extend`
    --         sources = {
    --             default = function()
    --                 local success, node = pcall(vim.treesitter.get_node)
    --                 if success and node and vim.tbl_contains({ "comment", "line_comment", "block_comment" }, node:type()) then
    --                     return { "buffer" }
    --                 else
    --                     return { "lazydev", "copilot", "lsp", "path", "snippets", "buffer" }
    --                 end
    --             end,
    --             per_filetype = {
    --                 codecompanion = { "codecompanion" },
    --             },
    --
    --             providers = {
    --                 lazydev = {
    --                     name = "LazyDev",
    --                     module = "lazydev.integrations.blink",
    --                     -- make lazydev completions top priority (see `:h blink.cmp`)
    --                     score_offset = 95,
    --                 },
    --                 copilot = {
    --                     name = "copilot",
    --                     module = "blink-copilot",
    --                     score_offset = 100,
    --                     async = true,
    --                     opts = {
    --                         kind_icon = "",
    --                         kind_hl = "DevIconCopilot",
    --                     },
    --                 },
    --                 path = {
    --                     score_offset = 95,
    --                     opts = {
    --                         get_cwd = function(_)
    --                             return vim.fn.getcwd()
    --                         end,
    --                     },
    --                 },
    --                 buffer = {
    --                     score_offset = 20,
    --                 },
    --                 lsp = {
    --                     -- Default
    --                     -- Filter text items from the LSP provider, since we have the buffer provider for that
    --                     transform_items = function(_, items)
    --                         return vim.tbl_filter(function(item)
    --                             return item.kind ~= require("blink.cmp.types").CompletionItemKind.Text
    --                         end, items)
    --                     end,
    --                     score_offset = 60,
    --                     fallbacks = { "buffer" },
    --                 },
    --                 -- Hide snippets after trigger character
    --                 -- Trigger characters are defined by the sources. For example, for Lua, the trigger characters are ., ", '.
    --                 snippets = {
    --                     score_offset = 70,
    --                     should_show_items = function(ctx)
    --                         return ctx.trigger.initial_kind ~= "trigger_character"
    --                     end,
    --                     fallbacks = { "buffer" },
    --                 },
    --                 cmdline = {
    --                     min_keyword_length = 2,
    --                     -- Ignores cmdline completions when executing shell commands
    --                     enabled = function()
    --                         return vim.fn.getcmdtype() ~= ":" or not vim.fn.getcmdline():match("^[%%0-9,'<>%-]*!")
    --                     end,
    --                 },
    --             },
    --         },
    --
    --         -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    --         -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    --         -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --         --
    --         -- See the fuzzy documentation for more information
    --         fuzzy = {
    --             implementation = "prefer_rust_with_warning",
    --             sorts = {
    --                 "exact",
    --                 -- defaults
    --                 "score",
    --                 "sort_text",
    --             },
    --         },
    --
    --         completion = {
    --             -- NOTE: some LSPs may add auto brackets themselves anyway
    --             accept = { auto_brackets = { enabled = true } },
    --             list = { selection = { preselect = true, auto_insert = false } },
    --             menu = {
    --                 border = "rounded",
    --                 max_height = 20,
    --                 draw = {
    --                     columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
    --                     components = {
    --                         kind_icon = {
    --                             ellipsis = false,
    --                             text = function(ctx)
    --                                 local icon = ctx.kind_icon
    --                                 if icon then
    --                                     -- Do nothing
    --                                 elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
    --                                     local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
    --                                     if dev_icon then
    --                                         icon = dev_icon
    --                                     end
    --                                 else
    --                                     icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
    --                                 end
    --                                 return icon .. ctx.icon_gap
    --                             end,
    --                             -- Optionally, use the highlight groups from nvim-web-devicons
    --                             -- You can also add the same function for `kind.highlight` if you want to
    --                             -- keep the highlight groups in sync with the icons.
    --                             highlight = function(ctx)
    --                                 local hl = ctx.kind_hl
    --                                 if hl then
    --                                     -- Do nothing
    --                                 elseif vim.tbl_contains({ "Path" }, ctx.source_name) then
    --                                     local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
    --                                     if dev_icon then
    --                                         hl = dev_hl
    --                                     end
    --                                 end
    --                                 return hl
    --                             end,
    --                         },
    --                     },
    --                 },
    --             },
    --             documentation = {
    --                 auto_show = true,
    --                 -- Delay before showing the documentation window
    --                 auto_show_delay_ms = 200,
    --                 window = {
    --                     min_width = 10,
    --                     max_width = 120,
    --                     max_height = 20,
    --                     border = "rounded",
    --                     winblend = 0,
    --                     winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
    --                     -- Note that the gutter will be disabled when border ~= 'none'
    --                     scrollbar = true,
    --                     -- Which directions to show the documentation window,
    --                     -- for each of the possible menu window directions,
    --                     -- falling back to the next direction when there's not enough space
    --                     direction_priority = {
    --                         menu_north = { "e", "w", "n", "s" },
    --                         menu_south = { "e", "w", "s", "n" },
    --                     },
    --                 },
    --             },
    --             -- Displays a preview of the selected item on the current line
    --             ghost_text = {
    --                 enabled = true,
    --                 -- Show the ghost text when an item has been selected
    --                 show_with_selection = true,
    --                 -- Show the ghost text when no item has been selected, defaulting to the first item
    --                 show_without_selection = false,
    --                 -- Show the ghost text when the menu is open
    --                 show_with_menu = true,
    --                 -- Show the ghost text when the menu is closed
    --                 show_without_menu = true,
    --             },
    --         },
    --
    --         signature = {
    --             enabled = true,
    --             window = {
    --                 min_width = 1,
    --                 max_width = 100,
    --                 max_height = 10,
    --                 border = "single", -- Defaults to `vim.o.winborder` on nvim 0.11+ or 'padded' when not defined/<=0.10
    --                 winblend = 0,
    --                 winhighlight = "Normal:BlinkCmpSignatureHelp,FloatBorder:BlinkCmpSignatureHelpBorder",
    --                 scrollbar = false, -- Note that the gutter will be disabled when border ~= 'none'
    --                 -- Which directions to show the window,
    --                 -- falling back to the next direction when there's not enough space,
    --                 -- or another window is in the way
    --                 direction_priority = { "n" },
    --                 -- Disable if you run into performance issues
    --                 treesitter_highlighting = true,
    --                 show_documentation = true,
    --             },
    --         },
    --
    --         cmdline = {
    --             completion = {
    --                 menu = {
    --                     auto_show = true,
    --                 },
    --             },
    --             -- stylua: ignore
    --             keymap = {
    --                 preset = "none",
    --                 ["<A-j>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
    --                 ["<A-k>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
    --                 ["<C-p>"] = { function(cmp) return cmp.select_prev({ auto_insert = false }) end, "fallback", },
    --                 ["<C-n>"] = { function(cmp) return cmp.select_next({ auto_insert = false }) end, "fallback", },
    --                 ["<Tab>"] = { function(cmp) return cmp.accept() end, "fallback", },
    --                 ["<CR>"] = { function(cmp) if vim.fn.getcmdtype() == ":" then return cmp.accept_and_enter() end return false end, "fallback", },
    --                 ["<A-/>"] = { function(cmp) if cmp.is_menu_visible() then return cmp.hide() else return cmp.show() end end, "fallback", },
    --             },
    --         },
    --     },
    --
    --     opts_extend = { "sources.default" },
    -- },
}

