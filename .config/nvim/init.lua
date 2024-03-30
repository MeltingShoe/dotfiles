-- TODO, add everything in this WISHLIST:
-- Navigate past EOF
-- zz. Try making cursor stay in middle
-- highlight yanked text
-- clear search highligght
-- expandtab, autoindent, tabstop, smartindent, 4 spaces per tab
-- https://vi.stackexchange.com/questions/3388/call-a-vim-function-silently
-- https://www.vim.org/scripts/script.php?script_id=1649
-- better macros
-- status bar
-- RICE
-- pop up command line

-- Set <space> as the leader key
-- See `:help mapleader`
-- --  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

--remove command bar
vim.opt.cmdheight=0

-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
-- Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = true

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'


-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Show which line your cursor is on
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- KEYMAPS
-- noremap dict
local opts = { noremap = true }

-- double j to escape
vim.keymap.set('i', 'jj', '<ESC>', { desc = 'double j to escape' })

-- Disable arrows in normal mode
vim.keymap.set('n','<Up>', '<Nop>')
vim.keymap.set('n','<Down>', '<Nop>')
vim.keymap.set('n','<Left>', '<Nop>')
vim.keymap.set('n','<Right>', '<Nop>')

-- Capital HJKL navigation
vim.keymap.set('n','H','^',opts)
vim.keymap.set('n','J','}',opts)
vim.keymap.set('n','K','{',opts)
vim.keymap.set('n','L','$',opts)

-- Insert newline without leaving normal mode
vim.keymap.set('n','<Leader>o','o<Esc>')
vim.keymap.set('n','<Leader>O','O<Esc>')

-- Insert mode navigation
vim.keymap.set('i','<Up>', '<Nop>')
vim.keymap.set('i','<Down>', '<Nop>')
vim.keymap.set('i','<Left>', '<Nop>')
vim.keymap.set('i','<Right>', '<Nop>')

vim.keymap.set('i','<C-h>','<Left>',opts)
vim.keymap.set('i','<C-j>','<Down>',opts)
vim.keymap.set('i','<C-k>','<Up>',opts)
vim.keymap.set('i','<C-l>','<Right>',opts)

-- Scroll when we jump to bottom of file
vim.keymap.set('n','G','Gzz',opts)

-- Leader + tab to indent
vim.keymap.set('n','<Tab>','>>',opts)
vim.keymap.set('n','<S-Tab>','<<',opts)

-- Capital Y to yank line for consistency
vim.keymap.set('n','Y','y$',opts)



-- PLUGIN CONFIG
--
-- Lazy nvim install
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

plugins = {{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
  keys = {
    { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
    { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
    { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
    { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
    { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
  },
}
}}
opts = {}

require("lazy").setup(plugins, opts)
require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'dracula',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
