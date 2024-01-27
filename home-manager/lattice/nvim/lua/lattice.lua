local lattice = {}

lattice.setup = function(use)
  require 'lattice/avigation'.setup(use)
  require 'lattice/bunt'.setup(use)
  require 'lattice/code'.setup(use)
  require 'lattice/data'.setup(use)
  require 'lattice/git'.setup(use)
  require 'lattice/keyboard'.setup(use)
  require 'lattice/lsp'.setup(use)
  require 'lattice/mpletion'.setup(use)
  require 'lattice/nippets'.setup(use)
  require 'lattice/other'.setup(use)
  require 'lattice/prose'.setup(use)
  require 'lattice/repl'.setup(use)
  require 'lattice/scope'.setup(use)
  require 'lattice/treesitter'.setup(use)
end

return lattice
