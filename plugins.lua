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
  use 'mfussenegger/nvim-dap'
  use {
    'mfussenegger/nvim-dap-python',
    run = 'python -m venv ~/.debugpy && ~/.debugpy/bin/python -m pip install debugpy'
  }
  use {
    'nvim-neotest/neotest',
    requires = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    }
  }
  use 'nvim-neotest/neotest-python'

  -- file navigation
  use {
    'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end
  }
  use 'junegunn/fzf.vim'

  -- universal vim settings
  use 'tpope/vim-sensible'
  use 'tpope/vim-surround'

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
      vim.keymap.set('<C-n>', ':NvimTreeToggle<CR>')
    end,
  }
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
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
      local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
      keyset("n", "<leader>d", "<Plug>(coc-definition)", {silent = true})
      keyset("n", "<leader>gy", "<Plug>(coc-type-definition)", {silent = true})
      keyset("n", "<leader>gi", "<Plug>(coc-implementation)", {silent = true})
      keyset("n", "<leader>gr", "<Plug>(coc-references)", {silent = true})
      keyset("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
      -- scroll popup
      keyset("n", "<C-j>", 'coc#float#has_scroll() ? coc#float#scroll(1, 5)" : "<c-w>j"',
             {silent = true, nowait = true, expr = true})
      keyset("n", "<C-k>", 'coc#float#has_scroll() ? coc#float#scroll(0, 5)" : "<c-w>k"',
             {silent = true, nowait = true, expr = true})
      keyset("i", "<C-j>", 'coc#float#has_scroll() ? "\\<c-j>=coc#float#scroll(1, 5)\\<cr>" : "\\<Right>"',
             {silent = true, nowait = true, expr = true, noremap=true})
      keyset("i", "<C-k>", 'coc#float#has_scroll() ? "\\<c-j>=coc#float#scroll(1, 5)\\<cr>" : "\\<Left>"',
             {silent = true, nowait = true, expr = true, noremap=true})
      -- suggestion select
      keyset("i", '<cr> coc#pum#visible() ? coc#pum#confirm() : "\\<CR>"', {expr=true, noremap=true})
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

  use 'plasticbok/vim-markdown'

  use {
    'scrooloose/nerdcommenter',
    config = function()
      vim.g.NERDDefaultAlign = 'left'
    end
  }
end)
