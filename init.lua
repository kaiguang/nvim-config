-- TODO: replace with lazy.nvim completely
-- require "user.packer"

-- ## Package manager

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
  -- Colorscheme
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {}, },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {},
  },
})

-- folke/tokyonight.nvim
require("tokyonight").setup({ style = "night", })
vim.cmd("colorscheme tokyonight")


-- ## Options

vim.opt.backup = false            -- creates a backup file
vim.opt.breakindent = true        -- Every wrapped line will continue visually indented (same amount of space as the beginning of that line).
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.cursorline = true         -- highlight the current line
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.linebreak = true          -- companion to wrap, don't split words
vim.opt.mouse = "a"               -- allow the mouse to be used in neovim
vim.opt.number = true             -- set numbered lines
vim.opt.scrolloff = 0             -- minimal number of screen lines to keep above and below the cursor
vim.opt.shiftwidth = 0            -- the number of spaces inserted for each indentation, when set to 0 it is the "tabstop" value
vim.opt.showmode = true           -- We need to see things like NORMAL, INSERT
vim.opt.showtabline = 2           -- always show tabs
vim.opt.sidescrolloff = 0         -- minimal number of screen columns either side of cursor if wrap is `false`
vim.opt.signcolumn = "yes"        -- Alaways show the signcolumn
vim.opt.smartcase = true          -- smart case
vim.opt.smartindent = true        -- make indenting smarter again
vim.opt.softtabstop = -1          -- When "sts" is negative, the value of "shiftwidth" is used.
vim.opt.splitbelow = true         -- force all horizontal splits to go below current window
vim.opt.splitright = true         -- force all vertical splits to go to the right of current window
vim.opt.swapfile = false          -- creates a swapfile
vim.opt.tabstop = 2               -- insert 2 spaces for a tab
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.undofile = true           -- enable persistent undo
vim.opt.spell = true
vim.opt.spelloptions = "camel"
vim.opt.spelllang = "en_us,en_ca,cjk"

-- Diable netrw to use nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- git-blame
vim.g.gitblame_enabled = 0                      -- Disable on start-up
vim.g.gitblame_date_format = "%Y-%m-%d %X (%a)" -- Custom date format

-- Add icons to the signcolumn
vim.fn.sign_define("DiagnosticSignError",  { text = "",  texthl = "DiagnosticSignError",  numhl = "DiagnosticSignError"  })
vim.fn.sign_define("DiagnosticSignWarn",   { text = "",  texthl = "DiagnosticSignWarn",   numhl = "DiagnosticSignWarn"  })
vim.fn.sign_define("DiagnosticSignHint",   { text = "",  texthl = "DiagnosticSignHint",   numhl = "DiagnosticSignHint"  })
vim.fn.sign_define("DiagnosticSignInfo",   { text = "",  texthl = "DiagnosticSignInfo",   numhl = "DiagnosticSignInfo"  })

-- Diagnostic config
vim.diagnostic.config({
  virtual_text = false,
  float = {
    border = "rounded",
    source = "always",
  },
})

-- ## Keymaps

-- Move cursor to other windows
-- vim.keymap.set('',  '<C-h>',           '<C-w>h')
-- vim.keymap.set('',  '<C-j>',           '<C-w>j')
-- vim.keymap.set('',  '<C-k>',           '<C-w>k')
-- vim.keymap.set('',  '<C-l>',           '<C-w>l')

-- vim.keymap.set('',  '<Space>t',        ':NvimTreeToggle<Enter>')
-- vim.keymap.set('',  '<Space>m',        ':Neoformat<Enter>')
-- vim.keymap.set('',  '<Space>g',        ':GitBlameToggle<Enter>')

-- vim.keymap.set('',  '<Space>f',        ':Telescope find_files<Enter>')
-- vim.keymap.set('',  '<Space>/',        ':Telescope live_grep<Enter>')

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
-- vim.keymap.set('n',  'gd',             vim.lsp.buf.definition)
-- vim.keymap.set('n',  'gr',             vim.lsp.buf.references)
-- vim.keymap.set('n',  'gh',             vim.lsp.buf.hover)
-- vim.keymap.set('n',  'ga',             vim.lsp.buf.code_action)
-- vim.keymap.set('n',  '<Space><Enter>', vim.lsp.buf.rename)
-- vim.keymap.set('n',  'go',             vim.diagnostic.open_float)

-- Diffview
-- vim.keymap.set('',  '<Space>v',        ':DiffviewOpen<Enter>')
-- vim.keymap.set('',  '<Space>b',        ':DiffviewClose<Enter>')

vim.keymap.set('n',  '<Space>w',        ':w<Enter>',       { desc = 'write' })
vim.keymap.set('n',  '<Space>wq',       ':wq<Enter>',      { desc = 'write & quit'})
vim.keymap.set('n',  '<Space>q',        ':q<Enter>',       { desc = 'quit'})

-- Use treesitter to fold
--[[vim.keymap.set('', '<Space>z', function()
  vim.opt.foldmethod = 'expr'
  vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
end)
--]]

-- Keymaps for treesitter incremental selection are defined in the treesitter.lua file.
-- init_selection = "<Down>",
-- node_incremental = "<Right>",
-- scope_incremental = "<Up>",
-- node_decremental = "<Left>",

-- Clear search highlight when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', ':nohls<Enter>')

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

-- TODO
-- require "user.telescope"
-- require "user.treesitter"
-- require "user.lualine"
-- require "user.bufferline"
-- require "user.lsp"
-- require "user.null-ls"
-- require "user.cmp"
-- require "user.luasnip"
-- require "user.nvim-tree"
-- require "user.comment"

-- Set cursor to vertical when leaving vim
vim.api.nvim_create_autocmd({"VimLeave"}, {
  pattern = {"*"},
  command = "set guicursor=a:ver100-blinkwait200-blinkon200-blinoff200",
})

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
