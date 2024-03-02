local git = {}

function git.setup()
  require('git-conflict').setup({})
  vim.g.blamer_enabled = true
  require("gitsigns").setup()
end

return git
