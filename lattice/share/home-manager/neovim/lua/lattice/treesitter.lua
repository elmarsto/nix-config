local treesitter = {}

function treesitter.setup(use)
  -- installed in nix https://nixos.wiki/wiki/Treesitter
  require "nvim-treesitter.configs".setup {
    highlight = {
      enable = true, -- false will disable the whole extension
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        -- TODO: figure out how to move these into keyboard.lua (look up function associated?)
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = "<Tab>",
        -- scope_decremental = "<S-Tab>",
        -- node_decremental = "<S-CR>"
      }
    },
    matchup = {
      enable = true
    },
    textsubjects = {
      enable = true,
      prev_selection = ',',
      keymaps = {
        -- TODO: figure out how to move these into keyboard.lua (look up function associated?)
        ["."] = "textsubjects-smart",
        [";"] = "textsubjects-container-outer",
        ["i;"] = "textsubjects-container-inner"
      }
    },
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = true
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_next_usage = "g*",
          goto_previous_usage = "g#"
        }
      }
    },
    indent = {
      enable = true
    },
    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'none',
        floating_preview_opts = {},
        peek_definition_code = {
          ["<leader>df"] = "@function.outer",
          ["<leader>dF"] = "@class.outer",
        },
      },
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = { query = "@class.outer", desc = "Next class start" },
          ["]o"] = "@loop.*",
          ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
          ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
        goto_next = {
          ["]d"] = "@conditional.outer",
        },
        goto_previous = {
          ["[d"] = "@conditional.outer",
        }
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
          ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
        },
        selection_modes = {
          ['@parameter.outer'] = 'v', -- charwise
          ['@function.outer'] = 'V',  -- linewise
          ['@class.outer'] = '<c-v>', -- blockwise
        },
        include_surrounding_whitespace = false,
      },
      swap = {
        enable = true,
        swap_next = {
          ["gx"] = "@parameter.inner",
        },
        swap_previous = {
          ["gX"] = "@parameter.inner",
        },
      },
    }
  }
  vim.cmd [[
      set foldmethod=expr
      set foldexpr=nvim_treesitter#foldexpr()
      set nofoldenable
  ]]
  vim.g.matchup_matchparen_offscreen = { method = "popup" }
  local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"

  -- Repeat movement with ; and ,
  -- ensure ; goes forward and , goes backward regardless of the last direction
  vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
  vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
  -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
  vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
  vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
  vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
  vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  require('treesj').setup()
  vim.keymap.set('n', 'gm', require('treesj').toggle)
  vim.keymap.set('n', 'gM', function()
    require('treesj').toggle({ split = { recursive = true } })
  end)
  use {
    "IndianBoy42/tree-sitter-just",
    config = function()
      require('tree-sitter-just').setup {}
    end
  }
end

return treesitter
