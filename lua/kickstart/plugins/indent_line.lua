vim.api.nvim_create_autocmd('FileType', {
  pattern = 'dashboard',
  callback = function()
    -- jeśli używasz indent-blankline.nvim
    vim.b.indent_blankline_enabled = false
    vim.opt.fillchars:append { eob = ' ' }

    -- jeśli używasz ibl.nvim
    pcall(function()
      require('ibl').setup_buffer(0, { enabled = false })
    end)
  end,
})

return {
  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- NOTE: nixCats: return true only if category is enabled, else false
    enabled = require('nixCatsUtils').enableForCategory 'kickstart-indent_line',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },
}
