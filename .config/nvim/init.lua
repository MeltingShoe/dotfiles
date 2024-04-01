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

-- disable bracket highlighting
-- TODO: Find a way to make bracket highlighting look good
vim.g.loaded_matchparen = false

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

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
vim.opt.clipboard = {'unnamed','unnamedplus'}

-- let g:clipboard = {
 --             'name': 'myClipboard',
    --          'copy': {
       --          '+': ['xsel', '-i -b', '-'],
          --       '*': ['xsel', '-i -b', '-'],
             --  },
 --             'paste': {
    --             '+': ['xsel', '-o -b', '-'],
       --          '*': ['xsel', '-o -p', '-'],
          --    },
             -- 'cache_enabled': 1,
 --           }

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
vim.opt.scrolloff = 12


-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')


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
vim.keymap.set('n','<Leader>o','o<Esc>',opts)
vim.keymap.set('n','<Leader>O','O<Esc>',opts)

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

plugins = {{'nvim-treesitter/nvim-treesitter'},{
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
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "c", "rust" },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}
