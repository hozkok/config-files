require('plugins')
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
os.execute('mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo')
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
