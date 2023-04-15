set nocompatible
filetype off
" WARNING: Install vim-plug with the following code,
" otherwise, vim will not work.
"
"curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" -*- VIM PLUG BEGIN -*-
call plug#begin(stdpath('data') . '/plugged')


" Plugins for using tags
function! BuildVimTags(info)
  if a:info.status != 'installed'
    return 0
  endif
  if has('macunix')
    !brew install universal-ctags
  else
    !sudo apt install universal-ctags
  endif
endfunction
Plug 'liuchengxu/vista.vim', { 'do': function('BuildVimTags') }
"Plug 'ludovicchabant/vim-gutentags'

" Plugins for colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'sainnhe/gruvbox-material'
Plug 'morhetz/gruvbox'

" async lua helpers for neovim
Plug 'nvim-lua/plenary.nvim'

" debugging
Plug 'mfussenegger/nvim-dap'
Plug 'mfussenegger/nvim-dap-python', { 'do': 'python -m venv ~/.debugpy && ~/.debugpy/bin/python -m pip install debugpy' }
Plug 'nvim-neotest/neotest'
Plug 'nvim-neotest/neotest-python'

" fast file navigation
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" universal vim settings
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'

" vimwiki is a personal note taker plugin
" (trying to make orgmode in vim)
Plug 'vimwiki/vimwiki'
""" 
""" " Vim async tasks support
""" " Plug 'Shougo/vimproc.vim', {'do' : 'make'}

"Plug 'davidhalter/jedi-vim', { 'do': 'git submodule update --init', 'for': 'python' }
""" 
""" " IPython integration
Plug 'ivanov/vim-ipython'
""" 
""" " Plug 'klen/python-mode'
Plug 'scrooloose/nerdtree'
Plug 'nvim-tree/nvim-web-devicons' " optional
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'vim-syntastic/syntastic'
"Plug 'neomake/neomake'
""" 
" better python indentation
Plug 'Vimjas/vim-python-pep8-indent'
""" " plugin for python pep8 checking
Plug 'nvie/vim-flake8', {'for': 'python'}
""" 
""" 
Plug 'vim-airline/vim-airline'
Plug 'yuttie/comfortable-motion.vim'

Plug 'sotte/presenting.vim'
Plug 'rbong/vim-flog'

"Auto-completion
if has('nvim')
    "Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    "let g:deoplete#enable_at_startup = 1
    "Plug 'zchee/deoplete-jedi', { 'do': 'git submodule update --init' }
    "Plug 'carlitux/deoplete-ternjs', { 'do': 'npm install -g tern' }
    "Plug 'sebastianmarkow/deoplete-rust'
    "let g:deoplete#sources#rust#racer_binary=$HOME .'/.cargo/bin/racer'
    "let g:deoplete#sources#rust#rust_source_path=$HOME . '/rust/src'
    "let g:deoplete#sources#ternjs#filetypes = [
    "            \ 'jsx',
    "            \ 'javascript.jsx',
    "            \ 'vue',
    "            \ ]
endif

" Plugins for HTML
Plug 'othree/html5-syntax.vim', { 'for': 'html' }
Plug 'othree/html5.vim', { 'for': 'html' }

" Plugins for JavaScript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'heavenshell/vim-jsdoc'
Plug 'Quramy/vim-js-pretty-template'

" Plugins for nodejs
Plug 'ternjs/tern_for_vim', {'do': 'npm install'}
Plug 'moll/vim-node'

" Plugins for TypeScript
Plug 'Quramy/tsuquyomi', {'do': 'npm install -g typescript'}
let g:tsuquyomi_disable_quickfix=1
"let g:syntastic_typescript_checkers=['tsuquyomi']
Plug 'leafgarland/typescript-vim'

Plug 'neoclide/coc.nvim', {'branch': 'release'}


" syntastic always show error location list
"let g:syntastic_always_populate_loc_list=1
"let g:syntastic_auto_loc_list=1
"" syntastic status line message settings
"set statusline+=%#warningmsg#
"set statusline+=%{SyntasticStatuslineFlag()}
"set statusline+=%*
""" 
" YouCompleteMe, generic completer
" Plug 'Valloric/YouCompleteMe', {'do': './install.py --clang-completer --java-completer --js-completer'}
""" 
" Plugin for Git integration
Plug 'tpope/vim-fugitive'
""" 
" Plugin for auto session creation
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-surround'
""" 
" plugins for vim-snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'honza/vim-snippets'
""" 
"Plugins for erlang
Plug 'vim-erlang/vim-erlang-omnicomplete'
Plug 'vim-erlang/vim-erlang-compiler'
Plug 'vim-erlang/vim-erlang-runtime'
""" 

" Plugins for elixir lang
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
""" 

""" Plugins for rust-lang
Plug 'rust-lang/rust.vim'
"""

""" Plugins for Clojure lang
Plug 'guns/vim-clojure-static'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
"""

""" Plugin for db
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
"""

" Tabular aligning items
Plug 'godlygeek/tabular'

" markdown
" highlight, matching rules and mappings for markdown
Plug 'plasticboy/vim-markdown'
" realtime markdown preview tool
" requires npm install -g instant-markdown-d
" Plug 'suan/vim-instant-markdown', {'do': 'npm install -g instant-markdown-d'}
""" 
" handy commenter
Plug 'scrooloose/nerdcommenter'
let g:NERDDefaultAlign = 'left'
""" 
"Plugins for Haskell
" cabal install ghc-mod
" add ~/.cabal/bin to $PATH
Plug 'eagletmt/ghcmod-vim'
let g:haskellmode_completion_ghc=0
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
let g:necoghc_enable_detailed_browse = 1
Plug 'eagletmt/neco-ghc'

call plug#end()
" -*- VIM-PLUG END -*-

set foldmethod=indent
set foldlevel=99

" setting <leader> key to comma
let mapleader = ","

" for Gdiff vertical open
set diffopt+=vertical

" disable mouse
set mouse=

" autocmd Filetype javascript,typescript,json,yaml,html setlocal ts=2 sts=2 sw=2 expandtab

" language specific indentation and character rules
au BufNewFile,BufRead *.js,*.html,*.css,*.ts,*.yml,*.yaml,*.json
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2 |
    \ set expandtab

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set smarttab

" show current line absolute number
" show relative line numbers on bot and top
set relativenumber
set number

set updatetime=500

" cause vim to move the cursor to the previous matching bracket for half a
" second.
set showmatch

" always display the statusline
set laststatus=2

" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase

" tab configuration
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab

" word wrap
set wrap
set linebreak
set nolist
set textwidth=0
set wrapmargin=0

set backspace=indent,eol,start

" indentation
set autoindent

" easier buffer switching
nnoremap <Leader>b :ls<CR>:b<Space>

" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
" set nobackup
" set nowritebackup
" set noswapfile

" set swap and backup directories, double slash prevents name collisions
silent !mkdir -p ~/.vim/backup ~/.vim/swap ~/.vim/undo
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=~/.vim/undo//

" show invisible tab indicator characters
" set listchars=tab:▸\ ,
" nmap <leader>l :set list!<CR>

" navigate between wrapped lines
" nmap <silent> k gk
" imap <silent> <C-o>k <C-o>gk
" nmap <silent> j gj
" imap <silent> <C-o>j <C-o>gj
" nmap <silent> ^ g<Home>
" imap <silent> <C-o>^ <C-o>g<Home>
" nmap <silent> $ g<End>
" imap <silent> <C-o>$ <C-o>g<End>

" easier moving of code blocks
" Try to go into visual mode (v), thenselect several lines of code here and
" then press ``>`` several times.
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

" to easily move though windows
nmap <C-j> <c-w>j
nmap <C-k> <c-w>k
nmap <C-l> <c-w>l
nmap <C-h> <c-w>h

" gundo plugin shortcut
map <leader>G :GundoToggle<CR>

" NERDTree plugin shortcut
"map <C-n> :NERDTreeToggle<CR>
" NvimTree toggle shortcut
map <C-n> :NvimTreeToggle<CR>

" jedi-vim configuration
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "0"

" vimwiki file format and path configuration
let g:vimwiki_list = [{'path': '~/vimwiki/',
                      \'syntax': 'markdown', 'ext': '.md'}]
let g:vimwiki_global_ext = 0
" let g:vimwiki_ext2syntax = {'.md': 'markdown'}


syntax on " syntax highlighting
filetype on " try to detect filetypes

" use python instead of python3 for tern support
" if(has("python"))
"     " enable tern shortcuts
"     let g:tern_map_keys=1
"     map <leader>td :TernDoc<CR>
"     map <leader>tb :TernDocBrowse<CR>
"     map <leader>tt :TernType<CR>
"     map <leader>tD :TernDef<CR>
"     map <leader>tpd :TernDefPreview<CR>
"     map <leader>tsd :TernDefSplit<CR>
"     map <leader>ttd :TernDefTab<CR>
"     map <leader>tr :TernRefs<CR>
"     map <leader>tR :TernRename<CR>
" endif

"if (has("python3"))
"    let g:jedi#force_py_version = 3
"endif
"if (has('nvim'))
"    let g:python3_host_prog = $HOME . '/.pyenv/shims/python3'
"endif

"syntax enable
"set t_Co=256
"let g:solarized_termcolors=256
"let g:solarized_termtrans=1
"let g:solarized_underline=0
"set background=dark
if has('termguicolors')
  set termguicolors
endif
let g:gruvbox_material_background='hard'
let g:gruvbox_material_better_performance=1
let g:airline_theme='gruvbox_material'
colorscheme gruvbox-material

set cc=80

filetype plugin indent on " enable loading indent file for filetype




" tell syntastic to use native python checker
" let g:syntastic_python_checkers = ['python', 'mypy']
"let g:neomake_python_enabled_makers = ['python']
"call neomake#configure#automake('nrwi', 500)

" python-mode configuration
" let g:pymode=0
" let g:pymode_indent=0
" let g:pymode_motion=0
" let g:pymode_doc=0
" let g:pymode_breakpoint=1
" let g:pymode_lint=0
" let g:pymode_rope=0
" let g:pymode_syntax=0
" let g:pymode_virtualenv=1 " Auto fix vim python paths if virtualenv enabled
" let g:pymode_folding=1  " Enable python folding
" let g:pymode_utils_whitespaces=0  " Do not autoremove unused whitespaces

" ignore pep257 missing docstring warning
" let g:pymode_lint_ignore = "C0110 Exported"

" let g:pymode_lint_minheight = 5   " Minimal height of pylint error window
" let g:pymode_lint_maxheight = 15  " Maximal height of pylint error window
" let g:pymode_lint_write = 0  " Disable pylint checking every save
" let g:pymode_run_key = "<leader>run"  " default key conflicts with jedi-vim
" let g:pymode_syntax_highlight_self=0  " do not highlight self
" let g:pymode_rope_vim_completion=0  " use jedi-vim for completion
" let g:pymode_rope_guess_project=0
" let g:pymode_doc_key="<leader>k"  " used jedi-vim for help
" let g:pymode_run_bind = '<leader>R'

" syntastic rules
let g:syntastic_javascript_checkers=['eslint']
let syntastic_mode_map = { 'passive_filetypes': ['html'] }
let g:jsdoc_enable_es6=1
autocmd FileType javascript nnoremap <leader>R :!node %<CR>

" enable jsx syntax highlighting in js files too
let g:jsx_ext_required=0

" use python3 for syntastic
let g:syntastic_python_python_exec='python3'

" === CtrlP Configurations ===
" ctrlp only look for directory of current file.
let g:ctrlp_working_path_mode = 'a'
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = 'node_modules\|.venv'


let g:snipMate = { 'snippet_version' : 1 }

" haskell configuration

" Enable project specific .vimrc files
"set exrc
"set secure
"
"
let g:tagbar_type_markdown = {
    \ 'ctagstype' : 'markdown',
    \ 'kinds' : [
        \ 'h:Heading_L1',
        \ 'i:Heading_L2',
        \ 'k:Heading_L3',
        \ 'l:Heading_L4',
        \ 'm:Heading_L5'
    \ ]
\ }

let g:vista_default_executive = 'coc'

" coc-nvim settings
autocmd CursorHold * silent call CocActionAsync('highlight') 
"hi default link CocHighlightText CursorColumn
"hi CocUnderline gui=underline term=underline
"hi CocErrorHighlight ctermfg=red  guifg=#c4384b gui=underline term=underline
"hi CocWarningHighlight ctermfg=yellow guifg=#c4ab39 gui=undercurl term=undercurl
" function! s:check_back_space() abort
"     let col = col('.') - 1
"     return !col || getline('.')[col - 1] =~# '\s'
" endfunction
" 

" general coc.nvim lsp mappings
set signcolumn=number
nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>gy <Plug>(coc-type-definition)
nmap <silent> <leader>gi <Plug>(coc-implementation)
nmap <silent> <leader>gr <Plug>(coc-references)
nmap <silent> <leader>rn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" show documentation
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocActionAsync('doHover')
    endif
endfunction
" scroll popup
nmap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1, 5) : "<c-w>j"
nmap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0, 5) : "<c-w>k"
inoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? "\<c-j>=coc#float#scroll(1, 5)\<cr>" : "\<Right>"
inoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? "\<c-k>=coc#float#scroll(0, 5)\<cr>" : "\<Left>"
vnoremap <silent><nowait><expr> <C-j> coc#float#has_scroll() ? coc#float#scroll(1, 5) : "\<C-j>"
vnoremap <silent><nowait><expr> <C-k> coc#float#has_scroll() ? coc#float#scroll(0, 5) : "\<C-k>"
" suggestion select
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

" WSL yank support
let s:clip = '/mnt/c/Windows/System32/clip.exe'  " change this path according to your mount point
if executable(s:clip)
    augroup WSLYank
        autocmd!
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system(s:clip, @0) | endif
    augroup END
endif

lua << EOF
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
  dappy.setup('~/.debugpy/bin/python')
  dappy.test_runner = 'pytest'
  vim.keymap.set('n', '<leader>xc', function() dap.continue() end)
  vim.keymap.set('n', '<leader>xn', function() dap.step_over() end)
  vim.keymap.set('n', '<leader>xs', function() dap.step_into() end)
  vim.keymap.set('n', '<leader>xr', function() dap.step_out() end)
  vim.keymap.set('n', '<leader>xu', function() dap.up() end)
  vim.keymap.set('n', '<leader>xd', function() dap.down() end)
  vim.keymap.set('n', '<leader>xb', function() dap.toggle_breakpoint() end)
  vim.keymap.set('n', '<leader>xl', function() dap.run_last() end)
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
      require("neotest-python")
    }
  })
  vim.keymap.set('n', '<leader>xtt', function() neotest.run.run() end)
  vim.keymap.set('n', '<leader>xtd', function() neotest.run.run({strategy='dap'}) end)
end
EOF
