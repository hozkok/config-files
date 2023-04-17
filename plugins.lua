return require('packer').startup(function (use)
  use 'wbthomason/packer.nvim'

  -- fn and variable tags
  use {
    'liuchengxu/vista.vim',
    run = function()
      if vim.fn.has('macunix') then
        os.execute('brew install universal-ctags')
      else
        os.execute('sudo apt install universal-ctags')
      end
    end,
    config = function()
      vim.g.vista_default_executive = 'coc'
    end
  }

  -- colorscheme
  use {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_better_performance = 1
      vim.g.airline_theme = 'gruvbox_material'
      vim.cmd.colorscheme('gruvbox-material')
    end
  }

  -- debugging
  use {
    --'nvim-neotest/neotest',
    -- for now, using this until
    -- https://github.com/nvim-neotest/neotest/pull/234 is merged
    'hozkok/neotest',
    requires = {
      "mfussenegger/nvim-dap",
      "mfussenegger/nvim-dap-python",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-neotest/neotest-python",
    },
    run = 'python -m venv ~/.debugpy && ~/.debugpy/bin/python -m pip install debugpy',
    config = function()
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
  }

  -- file navigation
  use {
    'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end
  }
  use 'junegunn/fzf.vim'

  -- universal vim settings
  use 'tpope/vim-sensible'

  -- personal note taking plugin (similar to orgmode in emacs)
  use {
    'vimwiki/vimwiki',
    config = function()
      vim.g.vimwiki_list = {
        {path = '~/vimwiki/', syntax = 'markdown', ext = '.md'},
      }
      vim.g.vimwiki_global_ext = 0
    end
  }

  -- file tree browser
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {'nvim-tree/nvim-web-devicons'},
    config = function()
      require('nvim-tree').setup()
      vim.keymap.set('n', '<C-n>', ':NvimTreeToggle<CR>')
    end,
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
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
    end
  }
  use 'vim-airline/vim-airline'

  -- smooth scrolling
  use 'yuttie/comfortable-motion.vim'

  -- git graph log visualisation
  use 'rbong/vim-flog'

  -- nice LSP client
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      vim.opt.signcolumn = "yes"
      local keyset = vim.keymap.set
      -- Use K to show documentation in preview window
      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
            vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
            vim.fn.CocActionAsync('doHover')
        else
            vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keyset("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
      -- Use <c-space> to trigger completion
      keyset("i", "<c-space>", "coc#refresh()", {silent = true, expr = true})
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold"
      })
      keyset("n", "<leader>d", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "<leader>gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "<leader>gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "<leader>gr", "<Plug>(coc-references)", {silent = true})
      keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
      -- -- scroll popup
      keyset("n", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1, 5) : "<c-w>j"',
             {silent = true, nowait = true, expr = true})
      keyset("n", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0, 5) : "<c-w>k"',
             {silent = true, nowait = true, expr = true})
      keyset("i", "<C-j>", 'coc#float#has_scroll() ? "\\<c-j>=coc#float#scroll(1, 5)\\<cr>" : "\\<Right>"',
             {silent = true, nowait = true, expr = true, remap=false})
      keyset("i", "<C-k>", 'coc#float#has_scroll() ? "\\<c-j>=coc#float#scroll(1, 5)\\<cr>" : "\\<Left>"',
             {silent = true, nowait = true, expr = true, remap=false})
      keyset("v", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1, 5) : "<c-w>j"',
             {silent = true, nowait = true, expr = true})
      keyset("v", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0, 5) : "<c-w>k"',
             {silent = true, nowait = true, expr = true})
      ---- suggestion select
      keyset("i", '<cr>', 'coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"', {expr=true, noremap=true})
    end
  }

  -- git integration
  use 'tpope/vim-fugitive'

  -- deal with text surrounding manipulation
  use 'tpope/vim-surround'

  -- rust <3
  use 'rust-lang/rust.vim'

  -- DBUI
  use {'kristijanhusak/vim-dadbod-ui', requires = {'tpope/vim-dadbod'}}

  use 'godlygeek/tabular'

  use 'plasticboy/vim-markdown'

  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDDefaultAlign = 'left'
    end
  }
end)
