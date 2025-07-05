local mpletion = {}

function mpletion.setup()
    require("cmp-npm").setup() -- TODO: - -> _ ?
    local lspkind = require "lspkind"
    local luasnip = require "luasnip"
    local cmp = require "cmp"
    local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end
    local insert = cmp.SelectBehavior.Insert
    local replace = cmp.SelectBehavior.replace
    local modes = {"i", "s", "c"}
    vim.opt.spell = true -- needed for cmp-spell
    vim.opt.spelllang = {"en_us"} -- needed for cmp-spel
    cmp.setup(
        {
            completion = {autocomplete = false},
            snippet = {
                expand = function(args)
                    require("luasnip").lsp_expand(args.body)
                end
            },
            mapping = cmp.mapping.preset.insert(
                {
                    ["<C-c>"] = cmp.mapping.close(),
                    ["<Escape>"] = cmp.mapping.close(),
                    ["<CR>"] = cmp.mapping.confirm(
                        {
                            behavior = replace,
                            select = true
                        }
                    ),
                    ["<Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_next_item({behavior = insert})
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.expand_or_jump()
                            elseif has_words_before() then
                                cmp.complete({reason = cmp.ContextReason.Manual})
                            else
                                fallback()
                            end
                        end,
                        modes
                    ),
                    ["<S-Tab>"] = cmp.mapping(
                        function(fallback)
                            if cmp.visible() then
                                cmp.select_prev_item({behavior = insert})
                            elseif luasnip.expand_or_jumpable() then
                                luasnip.jump(-1)
                            else
                                fallback()
                            end
                        end,
                        modes
                    )
                }
            ),
            sources = {
                {name = "rpncalc"},
                {name = "emoji"},
                {name = "luasnip"},
                {name = "nvim_lsp"},
                {name = "cmp_treesitter"},
                -- {name = "mkdnflow"},
                {name = "rg"},
                {name = "path"},
                {name = "buffer"},
                {name = "dictionary"},
                {name = "npm", keyword_length = 4},
                {
                    name = "spell",
                    option = {
                        enable_in_context = function()
                            return require("cmp.config.context").in_treesitter_capture("spell")
                        end
                    }
                }
            },
            formatting = {
                format = lspkind.cmp_format(
                    {
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "‥"
                    }
                )
            }
        }
    )

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(
        {"/", "?"},
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = {
                {name = "buffer"}
            }
        }
    )

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(
        ":",
        {
            mapping = cmp.mapping.preset.cmdline(),
            sources = cmp.config.sources(
                {
                    {name = "path"}
                },
                {
                    {
                        name = "cmdline",
                        option = {
                            ignore_cmds = {"Man", "!"}
                        }
                    }
                }
            )
        }
    )
end

return mpletion
