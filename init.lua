-- Disable netrw to use nvim-tree/nvim-tree.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Package manager
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  { 'rebelot/kanagawa.nvim', priority = 1000 },
  -- lua functions required by many other plugins
  { 'nvim-lua/plenary.nvim', },
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function () 
      local configs = require('nvim-treesitter.configs')

      configs.setup({
        ensure_installed = {
          'c',
          'css',
          'html',
          'json',
          'javascript',
          'lua',
          'markdown',
          'query',
          'tsx',
          'typescript',
          'vim',
          'vimdoc',
          'yaml', 
        },
        highlight = { enable = true },
        indent = { enable = true },  
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = 'gnn',
            node_incremental = 'grn',
            scope_incremental = 'grc',
            node_decremental = 'grm',
          },
        },
        -- JoosepAlviste/nvim-ts-context-commentstring
        context_commentstring = { enable = true, enable_autocmd = false, },
      })
    end,
  },
  { 'numToStr/Comment.nvim', lazy = false, },
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {}
    end,
  },
  { 'sbdchd/neoformat' },
  { 'nvim-telescope/telescope.nvim', tag = '0.1.4', },
  -- LSP
  { 'williamboman/mason.nvim', },
  { 'neovim/nvim-lspconfig', },
})

-- Colorscheme
vim.cmd.colorscheme 'kanagawa'

-- Options
vim.opt.backup = false            -- Creates a backup file
vim.opt.breakindent = true        -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line).
vim.opt.clipboard = 'unnamedplus' -- Allows neovim to access the system clipboard
vim.opt.cursorline = true         -- Highlight the current line
vim.opt.expandtab = true          -- Convert tabs to spaces
vim.opt.ignorecase = true         -- Ignore case in search patterns
vim.opt.linebreak = true          -- Companion to wrap, don't split words
vim.opt.mouse = 'a'               -- Allow the mouse to be used in neovim
vim.opt.number = true             -- Set numbered lines
vim.opt.shiftwidth = 0            -- The number of spaces inserted for each indentation, when set to 0 it is the 'tabstop' value
vim.opt.showtabline = 2           -- Always show tabs
vim.opt.smartcase = true          -- Smart case
vim.opt.smartindent = true        -- Make indenting smarter again
vim.opt.softtabstop = -1          -- When 'softtabstop' is negative, the value of 'shiftwidth' is used.
vim.opt.splitbelow = true         -- Force all horizontal splits to go below current window
vim.opt.splitright = true         -- Force all vertical splits to go to the right of current window
vim.opt.swapfile = false          -- Creates a swapfile
vim.opt.tabstop = 2               -- Insert 2 spaces for a tab
vim.opt.termguicolors = true      -- Set term GUI colors (most terminals support this)
vim.opt.undofile = true           -- Enable persistent undo

-- Spell checking `:help spell`
vim.opt.spelllang = 'en_us,en_ca,cjk'
vim.opt.spellcapcheck = ''
vim.opt.spelloptions = 'camel'
vim.opt.spell = true

-- git-blame
vim.g.gitblame_enabled = 0                      -- Disable on start-up
vim.g.gitblame_date_format = '%Y-%m-%d %X (%a)' -- Custom date format

-- Add icons to the signcolumn
vim.fn.sign_define('DiagnosticSignError',  { text = '',  texthl = 'DiagnosticSignError',  numhl = 'DiagnosticSignError' })
vim.fn.sign_define('DiagnosticSignWarn',   { text = '',  texthl = 'DiagnosticSignWarn',   numhl = 'DiagnosticSignWarn'  })
vim.fn.sign_define('DiagnosticSignHint',   { text = '',  texthl = 'DiagnosticSignHint',   numhl = 'DiagnosticSignHint'  })
vim.fn.sign_define('DiagnosticSignInfo',   { text = '',  texthl = 'DiagnosticSignInfo',   numhl = 'DiagnosticSignInfo'  })

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = 'rounded',
    source = 'always',
  },
})

-- Move cursor to other windows
-- vim.keymap.set('',  '<C-h>',           '<C-w>h')
-- vim.keymap.set('',  '<C-j>',           '<C-w>j')
-- vim.keymap.set('',  '<C-k>',           '<C-w>k')
-- vim.keymap.set('',  '<C-l>',           '<C-w>l')

vim.keymap.set('n',  '<Space>t',        ':NvimTreeToggle<Enter>') -- nvim-tree/nvim-tree
vim.keymap.set('n',  '<Space>f',        ':Neoformat<Enter>') -- sbdchd/neoformat
-- vim.keymap.set('',  '<Space>g',        ':GitBlameToggle<Enter>')

vim.keymap.set('',  '<Space>ff',        ':Telescope find_files<Enter>')
vim.keymap.set('',  '<Space>fg',        ':Telescope live_grep<Enter>')
vim.keymap.set('',  '<Space>fb',        ':Telescope buffers<Enter>')
vim.keymap.set('',  '<Space>fh',        ':Telescope help_tags<Enter>')

-- bufferline
-- vim.keymap.set('',  '˙',               ':BufferLineCyclePrev<Enter>') -- <Opt-h>
-- vim.keymap.set('',  '¬',               ':BufferLineCycleNext<Enter>') -- <Opt-l>
-- vim.keymap.set('',  '≤',               ':BufferLineMovePrev<Enter>')  -- <Opt-,>
-- vim.keymap.set('',  '≥',               ':BufferLineMoveNext<Enter>')  -- <Opt-.>
-- vim.keymap.set('',  '<Space>p',        ':BufferLinePick<Enter>')
-- vim.keymap.set('',  '<Space>c',        ':BufferLinePickClose<Enter>')
-- vim.keymap.set('',  '<Space>l',        ':BufferLineCloseLeft<Enter>')
-- vim.keymap.set('',  '<Space>r',        ':BufferLineCloseRight<Enter>')

-- LSP
vim.keymap.set('n',  'gd',             vim.lsp.buf.definition)
vim.keymap.set('n',  'gr',             vim.lsp.buf.references)
vim.keymap.set('n',  'gh',             vim.lsp.buf.hover)
vim.keymap.set('n',  'ga',             vim.lsp.buf.code_action)
vim.keymap.set('n',  'gr',             vim.lsp.buf.rename)
vim.keymap.set('n',  'go',             vim.diagnostic.open_float)

-- Diffview
-- vim.keymap.set('',  '<Space>v',        ':DiffviewOpen<Enter>')
-- vim.keymap.set('',  '<Space>b',        ':DiffviewClose<Enter>')

vim.keymap.set('n',  '<Space>w',        ':w<Enter>',       { desc = 'write' })
vim.keymap.set('n',  '<Space>wq',       ':wq<Enter>',      { desc = 'write & quit'})
vim.keymap.set('n',  '<Space>q',        ':q<Enter>',       { desc = 'quit'})

-- Use nvim-treesitter/nvim-treesitter to fold
vim.keymap.set('', '<Space>z', function()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end)

-- Clear search highlight when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', ':nohls<Enter>')

-- Highlight on yank
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- Bind p in visual mode to paste without overriding the current register
vim.keymap.set('v', 'p', 'pgvy')
-- Alternatively you can put it in the black hole register
-- vim.keymap.set('v', 'p', '"_dP')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- TODO
-- leap.nvim
-- Searching in all windows (including the current one) on the tab page.
--[[
vim.keymap.set('n', 's', function()
  require('leap').leap { target_windows = vim.tbl_filter(
    function (win) return vim.api.nvim_win_get_config(win).focusable end,
    vim.api.nvim_tabpage_list_wins(0)
  )}
end)
--]]

-- ## Keymaps end

-- TODO
-- require "user.lualine"
-- require "user.bufferline"
-- require "user.cmp"
-- require "user.luasnip"

-- Set cursor in terminal to vertical when leaving vim
vim.api.nvim_create_autocmd({'VimLeave'}, {
  pattern = {'*'},
  command = 'set guicursor=a:ver100-blinkwait200-blinkon200-blinkoff200',
})

-- JoosepAlviste/nvim-ts-context-commentstring
-- numToStr/Comment.nvim
require('Comment').setup {
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
}

-- LSP
require('mason').setup()
local lspconfig = require('lspconfig')
lspconfig.tsserver.setup {}

