local bunt = {}

function bunt.setup(use)
  use "amadeus/vim-convert-color-to"
  require "specs".setup {
    show_jumps = true,
    min_jump = 30,
    popup = {
      delay_ms = 0, -- delay before popup displays
      inc_ms = 10,  -- time increments used for fade/resize effects
      blend = 10,   -- starting blend, between 0-100 (fully transparent), see :h winblend
      width = 10,
      winhl = "PMenu",
      fader = require("specs").linear_fader,
      resizer = require("specs").shrink_resizer
    },
    ignore_filetypes = {},
    ignore_buftypes = {
      nofile = true
    }
  }
  require("todo-comments").setup {
    signs = true,           -- show icons in the signs column
    merge_keywords = false, -- use only these
    keywords = {
      BECAUSE = { icon = "∵", color = "argumentation" },
      BUG = { icon = "", color = "error" },
      BAD = { icon = "󰇸", color = "default" },
      BROKEN = { icon = "󰋮", color = "error" },
      CHALLENGE = { icon = "", color = "actionItem" },
      CLAIM = { icon = "➰", color = "argumentation" },
      CONCLUSION = { icon = "∴", color = "default" },
      CONTEXT = { icon = "❄", color = "info" },
      DECIDE = { icon = "", color = "actionItem" },
      DEF = { icon = "∆", color = "info" },
      DEFINITION = { icon = "∆", color = "info" },
      DISABLED = { icon = "", color = "default" },
      DOC = { icon = "", color = "info" },
      DOCUMENTATION = { icon = "", color = "info" },
      EXPLANATION = { icon = "∵", color = "argumentation" },
      FIXME = { icon = "", color = "error" },
      HACK = { icon = "󰣈", color = "info" },
      IDEA = { icon = "☀", color = "idea" },
      JUSTIFICATION = { icon = "∵", color = "argumentation" },
      LOOKUP = { icon = "󰊪", color = "actionItem" },
      MAYBE = { icon = "󰟶", color = "idea" },
      MNEMONIC = { icon = "󱍊", color = "info" },
      MN = { icon = "󱍊", color = "info" },
      NOMENCLATURE = { icon = "∆", color = "info" },
      NOTE = { icon = "❦", color = "info" },
      NICE = { icon = "", color = "idea" },
      PITCH = { icon = "♮", color = "argumentation" },
      PROMISE = { icon = "✪", color = "actionItem" },
      QED = { icon = "∴", color = "argumentation" },
      REASON = { icon = "∵", color = "argumentation" },
      REF = { icon = "", color = "info" },
      REFERENCE = { icon = "", color = "info" },
      RESEARCH = { icon = "⚗", color = "actionItem" },
      SAD = { icon = "󰋔", color = "default" },
      SECTION = { icon = "§", color = "info" },
      SRC = { icon = "", color = "info" },
      THEREFORE = { icon = "∴", color = "argumentation" },
      TIP = { icon = "󰓠", color = "argumentation" },
      TODO = { icon = "★", color = "actionItem" },
      URL = { icon = "", color = "info" },
      WARN = { icon = "󰀦", color = "warning" },
      WARNING = { icon = "󰀦", color = "warning" },
      WORRY = { icon = "⌇", color = "warning" },
      YIKES = { icon = "⁉", color = "error" },
      WHAA = { icon = "⁇", color = "default" },
    },
    colors = {
      actionItem = { "ActionItem", "#A0CC00" },
      argumentation = { "Argument", "#8C268C" },
      default = { "Identifier", "#999999" },
      error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
      idea = { "IdeaMsg", "#FDFF74" },
      info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
      warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FB8F24" },
    }
  }
  vim.cmd [[
    set termguicolors
    let g:aurora_italic = 1
    let g:aurora_transparent = 1
    let g:aurora_bold = 0
    let g:aurora_darker = 1

    colorscheme aurora
    "  My fixes
    hi SpellBad guifg=#999999 guibg=NONE ctermbg=NONE gui=NONE cterm=NONE guisp=#999999
    hi Boolean guifg=#c4a2ff gui=NONE cterm=NONE
    hi @constant.builtin guifg=#c4a2ff gui=NONE cterm=NONE
    hi @repeat guifg=#EE82EE gui=NONE cterm=NONE
    hi @keyword guifg=#EE82EE gui=NONE cterm=NONE
    hi @keyword.return guifg=#EE82EE gui=NONE cterm=NONE
    hi @keyword.operator guifg=#EE82EE gui=NONE cterm=NONE
    hi @label.json guifg=#EE82EE gui=NONE cterm=NONE
    hi @label.jsonc guifg=#EE82EE gui=NONE cterm=NONE

    " " customize your own highlight with lua
    " lua <<EOF
    "   vim.api.nvim_set_hl(0, '@string', {fg='#59E343'})
    "   vim.api.nvim_set_hl(0, '@field', {fg='#f93393'})
    "   vim.api.nvim_set_hl(0, '@number', {fg='#e933e3'})
    " EOF
  ]]
  require("neoscroll").setup(
    {
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      easing_function = "quadratic" -- Default easing function
    }
  )
  require("lualine").setup({
    options = {
      theme = "everforest"
    },
    sections = {
      lualine_b = {
        'vim.loop.cwd()',
        'branch',
        'diff',
        'diagnostics',
      },
      lualine_c = { {
        'filename',
        file_status = true,
        newfile_status = true,
        path = 1,
        shorting_target = 40,
        symbols = {
          modified = '⊙',
          readonly = '⊘',
          unnamed = '⊚',
          newfile = '⊛',
        }
      } },
      lualine_y = {
        "progress",
      },
      lualine_z = {
        "location",
        function()
          return tostring(vim.fn.wordcount().words)
        end,
      }
    }
  })
  require "colorizer".setup()
  require('lspkind').init({
    preset = 'default'
  })
  require("notify").setup({
    background_colour = "#000000",
  })
  require("winshift").setup({
    highlight_moving_win = true,
    focused_hl_group = "Visual",
    moving_win_options = {
      wrap = false,
      cursorline = false,
      cursorcolumn = false,
      colorcolumn = "",
    },
    keymaps = {
      disable_defaults = false,
      win_move_mode = {
        ["h"] = "left",
        ["j"] = "down",
        ["k"] = "up",
        ["l"] = "right",
        ["H"] = "far_left",
        ["J"] = "far_down",
        ["K"] = "far_up",
        ["L"] = "far_right",
        ["<left>"] = "left",
        ["<down>"] = "down",
        ["<up>"] = "up",
        ["<right>"] = "right",
        ["<S-left>"] = "far_left",
        ["<S-down>"] = "far_down",
        ["<S-up>"] = "far_up",
        ["<S-right>"] = "far_right",
      },
    },
    window_picker = function()
      return require("winshift.lib").pick_window({
        picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
        filter_rules = {
          cur_win = true, -- Filter out the current window
          floats = true,  -- Filter out floating windows
          filetype = {},  -- List of ignored file types
          buftype = {},   -- List of ignored buftypes
          bufname = {},   -- List of vim regex patterns matching ignored buffer names
        },
      })
    end,
  })
  require("scrollbar").setup()
end

return bunt
