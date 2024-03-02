local scope = {}

function scope.setup(use)
  local tscope = require("telescope")
  tscope.setup {
    extensions = {
      media_files = {
        filetypes = { "png", "webp", "jpg", "jpeg" },
        find_cmd = "rg"
      },
    }
  }
  tscope.load_extension "frecency"
  tscope.load_extension "project"
  tscope.load_extension "undo"
  use { "fdschmidt93/telescope-egrepify.nvim",
    config = function()
      require "telescope".load_extension "egrepify"
    end
  }
end

return scope
