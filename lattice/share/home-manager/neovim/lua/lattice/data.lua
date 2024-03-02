local data = {}

function data.setup()
  vim.api.nvim_exec(
    [[
        autocmd FileType sql,mysql,plsql lua require('cmp').setup.buffer({ sources = {{ name = 'vim-dadbod-completion' }} })
      ]],
    true
  )
end

return data
