require('plugins')

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

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
    vim.o.smarttab = true
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
vim.o.ignorecase = true
vim.o.smartcase = true
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
vim.o.exrc = true
vim.keymap.set('n', '<leader>b', ':ls<CR>:b<Space>', {remap = false})
do
  local vimdir = vim.env.HOME .. '/.vim'
  vim.o.backupdir = vimdir .. '/backup//'
  vim.o.directory = vimdir .. '/swap//'
  vim.o.undodir = vimdir .. '/undodir//'
end

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

vim.o.cc = '80'

-- WSL yank support
if(vim.fn.executable('clip.exe') ~= 0) then
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

_G.remote_docker_debug_cmd = function(command)
  local container_name = command.args
  local dap = require('dap')
  local container_ls = ("docker container ls -qf 'name=%s'"):format(container_name)
  local function exec(cmd)
    return (io.popen(cmd, "r")):read("l")
  end
  local container_id = exec(container_ls)
  if container_id == nil then
    print("cannot access the container, make sure it is running")
    return
  end
  local container_ip = exec(
    ("docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' %s"):format(container_id)
  )
  dap.run(
    {
      type = "python",
      request = "attach",
      justMyCode = false,
      name = "docker remote debugger",
      connect = {
        host = container_ip,
        port = 5678
      },
      pathMappings = {
        {
          localRoot = vim.fn.getcwd(),
          remoteRoot = "/app",
        }
      },
    }
  )
end
vim.api.nvim_create_user_command(
  "DebugDocker", _G.remote_docker_debug_cmd, {nargs=1}
)
