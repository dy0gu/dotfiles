-- Use lazy.nvim plugin manager.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- Latest stable release.
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Load plugins.
require("lazy").setup({
    { "EdenEast/nightfox.nvim",          priority = 1000, },
    { "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" },
    { "nvim-lualine/lualine.nvim",       requires = { "kyazdani42/nvim-web-devicons", opt = true } },
    { "nvim-telescope/telescope.nvim",   requires = { "nvim-lua/plenary.nvim" } },
    { "folke/trouble.nvim",              opts = {},                                                cmd = "Trouble", },
    { "lewis6991/gitsigns.nvim",         config = function() require("gitsigns").setup() end },
    {
        "goolord/alpha-nvim",
        config = function()
            require "alpha".setup(require "alpha.themes.dashboard".config)
        end
    },
})

-- Change color scheme.
vim.cmd("colorscheme carbonfox")

-- Basic settings.
vim.opt.termguicolors = true  -- Enable 24-bit RGB color in the TUI.
vim.opt.number = true         -- Show line numbers.
vim.opt.relativenumber = true -- Show relative line numbers.
vim.opt.tabstop = 4           -- Number of spaces tabs count for.
vim.opt.shiftwidth = 4        -- Number of spaces to use for each step of (auto)indent.
vim.opt.expandtab = false     -- Use spaces instead of tabs.
vim.opt.smartindent = true    -- Enable smart indentation.
vim.opt.wrap = false          -- Disable line wrap.
vim.opt.swapfile = false      -- Do not use swapfile.

-- Bind ctrl+s to save file.
vim.api.nvim_set_keymap("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })

-- Bind ctrl+q to quit.
vim.api.nvim_set_keymap("", "<C-q>", "<Esc>:q<CR>", { noremap = true, silent = true })
-- Bind ctrl+f+q to force quit.
vim.api.nvim_set_keymap("", "<C-f><C-q>", "<Esc>:qa!<CR>", { noremap = true, silent = true })
