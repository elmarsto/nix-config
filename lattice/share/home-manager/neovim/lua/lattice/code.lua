local code = {}

function code.setup()
  require("Comment").setup()
  require("formatter").setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      nix = {
        require("formatter.filetypes.nix").alejandra
      },
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }
  }
  vim.cmd [[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost * FormatWrite
    augroup END
  ]]
  require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt", "vim", "markdown", "guihua", "guihua_rust", "clap_input" }
  })
end

return code
