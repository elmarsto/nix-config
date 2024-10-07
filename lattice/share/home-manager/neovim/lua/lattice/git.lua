local git = {}

function git.setup()
  -- require('git-conflict').setup({}) -- disabled 2024 Oct 07, was causing conflicts
  vim.g.blamer_enabled = true
  require("gitsigns").setup()
end

return git
