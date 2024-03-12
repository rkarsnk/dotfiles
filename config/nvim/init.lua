vim.scriptencodeing = "utf-8"
vim.opt.encoding= "utf-8"
vim.opt.fileencoding= "utf-8","cp932","euc-jp","sjis"

vim.opt.number = true
vim.opt.signcolumn = 'no'

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.swapfile = false -- スワップファイルを作成しない

vim.opt.fileformats= "unix","dos","mac"


-- lazy.vim --
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


-- Plugins
local plugins = {

  -- Vim Markdown
  "godlygeek/tabular",
  "preservim/vim-markdown",


  -- Highlight 
  {
    "nvim-treesitter/nvim-treesitter",
    build = function() pcall(require("nvim-treesitter.install").update) end,
    dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"},
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = {"nvim-treesitter/nvim-treesitter"},
  },

  -- Colorschemes
  "rkarsnk/onenord.nvim",
  --"mhartington/oceanic-next",

}


local opts = {
  install = {
    missing = true,
  },
  checker = {
    enabled = true,
    concurrency = nil,
    notify = true,
    frequency = 43200,
  },
}


require("lazy").setup(plugins, opts)

-- Onenord Theme
onenord_theme = {
  theme = "dark",
}
require("onenord").setup(onenord_theme)

