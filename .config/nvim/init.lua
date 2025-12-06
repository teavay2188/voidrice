-- 1. Install/Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

-- 2. Load Core Configuration
-- Source the options first
require("core.options")

-- 3. Setup lazy.nvim and Plugins
require("lazy").setup(require("plugins"), {
  -- Configuration options for lazy.nvim
  checker = { enabled = true },
  change_detection = { notify = false },
  -- ... other performance options
})

-- 4. Load remaining Core Configuration (must be after plugins are loaded)
require("core.keymaps")
require("core.autocmds")
