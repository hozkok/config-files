vim.o.foldmethod = 'indent'
vim.o.foldlevel = 99
vim.opt.diffopt = vim.opt.diffopt + 'vertical'
vim.o.mouse = ''
vim.g.mapleader = ','

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = '*.py',
  callback = function()
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
    vim.bo.shiftwidth = 4
    vim.bo.expandtab = true
    vim.bo.smarttab = true
  end
})

vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
  pattern = {'*.js', '*.html', '*.css', '*.ts', '*.yml', '*.yaml', '*.json', '*.lua'},
  callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
    vim.bo.expandtab = true
  end
})

vim.o.relativenumber = true
vim.o.number = true
vim.o.updatetime = 500
-- cause vim to move the cursor to the previous matching bracket for half a
-- second.
vim.o.showmatch = true
vim.o.laststatus = 2
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.smarttab = false
vim.o.wrap = true
vim.o.linebreak = true
vim.o.list = false
vim.o.textwidth = 0
vim.o.wrapmargin = 0
vim.o.backspace = 'indent,eol,start'
vim.o.autoindent = true
vim.keymap.set('n', '<leader>b', ':ls<CR>:b<Space>', {remap = false})
os.execute('!mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo')
vim.o.backupdir = '~/.vim/backup//'
vim.o.directory = '~/.vim/swap//'
vim.o.undodir = '~/.vim/undo//'

-- better indentation
vim.keymap.set('v', '<', '<gv', {remap = false})
vim.keymap.set('v', '>', '>gv', {remap = false})

-- to easily move through windows
vim.keymap.set('n', '<C-j>', '<c-w>j')
vim.keymap.set('n', '<C-k>', '<c-w>k')
vim.keymap.set('n', '<C-l>', '<c-w>l')
vim.keymap.set('n', '<C-h>', '<c-w>h')

-- disable checks for python; there is no plugin dependency using python
-- this is mostly required for legacy vim plugins that depend on python
-- most plugins nowadays use lua instead.
vim.g.loaded_python3_provider = 0

if vim.fn.has('termguicolors') then
    vim.o.termguicolors = true
end

vim.o.cc = 80

-- WSL yank support
if vim.fn.executable('clip.exe') then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

-----------------
require("nvim-tree").setup()
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "lua", "vim", "vimdoc", "query", "python" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- disable = { "c", "rust" },
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

-- neovim-dap and neotest configs for debugging
do
  local dap = require('dap')
  local dappy = require('dap-python')
  local widgets = require('dap.ui.widgets')
  local neotest = require('neotest')
  local neotestpy = require('neotest-python')
  dappy.setup('~/.debugpy/bin/python')
  dappy.test_runner = 'pytest'
  vim.keymap.set('n', '<leader>x', function() end) -- noop to prevent `x` on timeout
  vim.keymap.set('n', '<leader>xc', function() dap.continue() end)
  vim.keymap.set('n', '<leader>xn', function() dap.step_over() end)
  vim.keymap.set('n', '<leader>xs', function() dap.step_into() end)
  vim.keymap.set('n', '<leader>xr', function() dap.step_out() end)
  vim.keymap.set('n', '<leader>xu', function() dap.up() end)
  vim.keymap.set('n', '<leader>xd', function() dap.down() end)
  vim.keymap.set('n', '<leader>xb', function() dap.toggle_breakpoint() end)
  vim.keymap.set('n', '<leader>xl', function() dap.run_to_cursor() end)
  vim.keymap.set('n', '<leader>xii', function() dap.repl.open() end)
  vim.keymap.set({'n', 'v'}, '<Leader>xh', function()
    widgets.hover()
  end)
  vim.keymap.set({'n', 'v'}, '<Leader>xp', function()
    widgets.preview()
  end)
  vim.keymap.set('n', '<Leader>xff', function()
    widgets.centered_float(widgets.frames)
  end)
  vim.keymap.set('n', '<Leader>xfs', function()
    widgets.centered_float(widgets.scopes)
  end)
  neotest.setup({
    adapters = {
      neotestpy({
        dap = { justMyCode = false },
      })
    },
    status = {
      enabled = false,
    },
  })
  vim.keymap.set('n', '<leader>xtt', function() neotest.run.run() end)
  vim.keymap.set('n', '<leader>xtd', function()
    neotest.run.run({strategy='dap'})
  end)
  vim.api.nvim_create_user_command(
    'DapClearBreakpoints', dap.clear_breakpoints, {nargs=0}
  )
  vim.api.nvim_create_user_command(
    'NeotestOutput', neotest.output_panel.toggle, {nargs=0}
  )
  vim.api.nvim_create_user_command(
    'NeotestSummary', neotest.summary.toggle, {nargs=0}
  )
end
