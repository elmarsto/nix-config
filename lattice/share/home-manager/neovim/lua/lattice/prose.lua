local prose = {}

function prose.setup(use)
    vim.cmd("autocmd Filetype markdown set autowriteall")
    require("mkdnflow").setup(
        {
            modules = {
                bib = true,
                buffers = true,
                conceal = true,
                cursor = true,
                folds = true,
                foldtext = true,
                links = true,
                lists = true,
                maps = true,
                paths = true,
                tables = true,
                yaml = true,
                cmp = true
            },
            filetypes = {md = true, rmd = true, markdown = true},
            create_dirs = false,
            perspective = {
                priority = "current",
                fallback = "root",
                root_tell = "SUMMARY.md",
                nvim_wd_heel = false,
                update = false
            },
            wrap = true,
            bib = {
                default_path = nil,
                find_in_root = true
            },
            silent = false,
            cursor = {
                jump_patterns = nil
            },
            links = {
                style = "markdown",
                name_is_source = false,
                conceal = false,
                context = 0,
                implicit_extension = nil,
                transform_implicit = false,
                transform_explicit = function(text)
                    text = text:gsub(" ", "-")
                    text = text:lower()
                    text = os.date("+%Y.%m.%d_%H.%M.%S") .. text
                    return (text)
                end,
                create_on_follow_failure = false
            },
            new_file_template = {
                use_template = true,
                placeholders = {
                    before = {
                        title = "link_title",
                        date = function()
                            return os.date("+%Y.%m.%d_%H.%M.%S")
                        end
                    },
                    after = {}
                },
                template = "# {{ title }}"
            },
            to_do = {
                symbols = {" ", "-", "X"},
                update_parents = true,
                not_started = " ",
                in_progress = "-",
                complete = "X"
            },
            foldtext = {
                object_count = true,
                object_count_icons = "emoji",
                object_count_opts = function()
                    return require("mkdnflow").foldtext.default_count_opts()
                end,
                line_count = true,
                line_percentage = true,
                word_count = false,
                title_transformer = nil,
                separator = " · ",
                fill_chars = {
                    left_edge = "⢾",
                    right_edge = "⡷",
                    left_inside = " ⣹",
                    right_inside = "⣏ ",
                    middle = "⣿"
                }
            },
            tables = {
                trim_whitespace = true,
                format_on_move = true,
                auto_extend_rows = false,
                auto_extend_cols = false,
                style = {
                    cell_padding = 1,
                    separator_padding = 1,
                    outer_pipes = true,
                    mimic_alignment = true
                }
            },
            yaml = {
                bib = {override = false}
            },
            mappings = {
                MkdnEnter = {{"n", "v"}, "<CR>"},
                MkdnTab = false,
                MkdnSTab = false,
                MkdnNextLink = {"n", "<Tab>"},
                MkdnPrevLink = {"n", "<S-Tab>"},
                MkdnNextHeading = {"n", "]]"},
                MkdnPrevHeading = {"n", "[["},
                MkdnGoBack = {"n", "<M-BS>"},
                MkdnGoForward = {"n", "<M-Del>"},
                MkdnCreateLink = false, -- see MkdnEnter
                MkdnCreateLinkFromClipboard = {{"n", "v"}, "<leader>p"}, -- see MkdnEnter
                MkdnFollowLink = false, -- see MkdnEnter
                MkdnDestroyLink = {"n", "<M-CR>"},
                MkdnTagSpan = {"v", "<M-CR>"},
                MkdnMoveSource = {"n", "<F2>"},
                MkdnYankAnchorLink = {"n", "yaa"},
                MkdnYankFileAnchorLink = {"n", "yfa"},
                MkdnIncreaseHeading = {"n", "<M-+>"},
                MkdnDecreaseHeading = {"n", "<M-->"},
                MkdnToggleToDo = {{"n", "v"}, "<C-Space>"},
                MkdnNewListItem = false,
                MkdnNewListItemBelowInsert = {"n", "o"},
                MkdnNewListItemAboveInsert = {"n", "O"},
                MkdnExtendList = false,
                MkdnUpdateNumbering = {"n", "<leader>nn"},
                MkdnTableNextCell = {"i", "<Tab>"},
                MkdnTablePrevCell = {"i", "<S-Tab>"},
                MkdnTableNextRow = false,
                MkdnTablePrevRow = {"i", "<M-CR>"},
                MkdnTableNewRowBelow = {"n", "<leader>ir"},
                MkdnTableNewRowAbove = {"n", "<leader>iR"},
                MkdnTableNewColAfter = {"n", "<leader>ic"},
                MkdnTableNewColBefore = {"n", "<leader>iC"},
                MkdnFoldSection = {"n", "<leader>f"},
                MkdnUnfoldSection = {"n", "<leader>F"}
            }
        }
    )
end

return prose
