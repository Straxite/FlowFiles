-- Need this fr fr cuz u wanna be lazy?? :)

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

-- You need this :)

require("vim-options")
require("lazy").setup("plugins", {
     git = {
       timeout = 600, -- seconds, default is much lower
     },
   })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })

-- A random color import??

require("colors")
local colors1 = require("colors")

-- Load plugin configs

require("config/config-lualine")
require("config/config-colorizer")
require("config/config-devicon")
