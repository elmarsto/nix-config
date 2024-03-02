local other = {}

function other.setup(use)
  require("ssr").setup {
    border = "rounded",
    min_width = 50,
    min_height = 5,
    max_width = 120,
    max_height = 25,
    adjust_window = true,
    keymaps = {
      close = "q",
      next_match = "n",
      prev_match = "N",
      replace_confirm = "<cr>",
      replace_all = "<leader><cr>",
    },
  }
  vim.keymap.set({ "n", "x" }, "<leader>/", function() require("ssr").open() end)

  require('boole').setup({
    mappings = {
      increment = '<C-a>',
      decrement = '<C-x>'
    },
    -- User defined loops
    additions = {
      { 'Foo', 'Bar' },
      { 'tic', 'tac', 'toe' }
    },
    allow_caps_additions = {
      { 'enable', 'disable' }
      -- enable → disable
      -- Enable → Disable
      -- ENABLE → DISABLE
    }
  })
  vim.g.unception_block_while_host_edits = true

  require("live-command").setup {
    commands = {
      Norm = { cmd = "norm" },
    },
  }
  -- TODO: move to keyboard.lua
  vim.cmd [[
      " misc mappings
      nnoremap Q @@
      nnoremap gH :execute "OpenBrowser" "https://github.com/" . expand("<cfile>")  <cr>
      nnoremap gN :execute "OpenBrowser" "https://search.nixos.org/packages?query=" . expand("<cfile>")  <cr>

      " Paste-mode shenanigans
      function! TogglePaste()
          if(&paste == 0)
              set paste
              echo "Paste Mode Enabled"
          else
              set nopaste
              echo "Paste Mode Disabled"
          endif
      endfunction
      map <leader>p :call TogglePaste()<cr>

  ]]
end

return other
