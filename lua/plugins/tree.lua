-- NOTE: Tree Explorer files conventional
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = true,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    -- disable netrw at the very start of your init.lua
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- optionally enable 24-bit colour
    vim.opt.termguicolors = true

    -- OR setup with some options
    require("nvim-tree").setup({
      sort = {
        sorter = "case_sensitive",
      },
      view = {
        width = 30,
      },
      renderer = {
        group_empty = true,
      },
      filters = {
        dotfiles = false,
        git_ignored = false,
      },
    })
  end,
  keys = {
    {'<leader>et', '<cmd>NvimTreeOpen<CR>', desc = 'Nvimtree: Open Nvimtree' },
    {'<leader>ec', '<cmd>NvimTreeClose<CR>', desc = 'Nvimtree: Close Nvimtree' }
  },
}
