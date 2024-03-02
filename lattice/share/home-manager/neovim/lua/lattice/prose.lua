local prose = {}

function prose.setup(use)
  vim.cmd("autocmd Filetype markdown set autowriteall")
  require("mkdnflow").setup({
    links = {
      transform_explicit = function(text)
        text = text:gsub(" ", "-")
        text = text:lower()
        return (text)
      end
    }
  })
end

return prose
