local code = {}

function code.setup()
  require("Comment").setup()
  require("formatter").setup {
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }
  }
  require('nvim-autopairs').setup({
    disable_filetype = { "TelescopePrompt", "vim", "markdown", "guihua", "guihua_rust", "clap_input" }
  })
end

return code
