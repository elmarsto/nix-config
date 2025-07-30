local avigation = {}
function avigation.setup(use)
    require "marks".setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = {".", "<", ">", "^"},
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = {lower = 10, upper = 15, builtin = 8, bookmark = 20},
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
            sign = "⚑",
            virt_text = "hello world",
            -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
            -- defaults to false.
            annotate = false
        },
        mappings = {}
    }
    require("ibl").setup()
    use {
        "kiyoon/treesitter-indent-object.nvim",
        config = function()
            -- select context-aware indent
            vim.keymap.set(
                {"x", "o"},
                "ai",
                function()
                    require "treesitter_indent_object.textobj".select_indent_outer()
                end
            )
            -- ensure selecting entire line (or just use Vai)
            vim.keymap.set(
                {"x", "o"},
                "aI",
                function()
                    require "treesitter_indent_object.textobj".select_indent_outer(true)
                end
            )
            -- select inner block (only if block, only else block, etc.)
            vim.keymap.set(
                {"x", "o"},
                "ii",
                function()
                    require "treesitter_indent_object.textobj".select_indent_inner()
                end
            )
            -- select entire inner range (including if, else, etc.) in line-wise visual mode
            vim.keymap.set(
                {"x", "o"},
                "iI",
                function()
                    require "treesitter_indent_object.textobj".select_indent_inner(true, "V")
                end
            )
        end
    }
    require "oil".setup(
        {
            columns = {
                "icon"
            },
            view_options = {
                show_hidden = true
            },
            keymaps = {
                ["-"] = "actions.parent",
                ["<C-c>"] = "actions.close",
                ['<C-">'] = "actions.select_split",
                ["<C-l>"] = "actions.refresh",
                ["<C-p>"] = "actions.preview",
                ["<C-%>"] = "actions.select_vsplit",
                ["<C-t>"] = "actions.select_tab",
                ["<CR>"] = "actions.select",
                ["_"] = "actions.open_cwd",
                ["`"] = "actions.tcd",
                ["~"] = "actions.cd",
                ["g."] = "actions.toggle_hidden",
                ["g?"] = "actions.show_help",
                ["g\\"] = "actions.toggle_trash",
                ["gs"] = "actions.change_sort",
                ["gx"] = "actions.open_external",
                ["y"] = "actions.copy_entry_path",
                ["!"] = "actions.open_terminal",
                [";"] = "actions.open_cmdline",
                ["g:"] = "actions.open_cmdline_dir"
            },
            vim.keymap.set("n", "-", require("oil").open, {desc = "Open parent directory"})
        }
    )
end

return avigation
