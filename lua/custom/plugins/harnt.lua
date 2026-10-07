return {
  {
    'PieterPel/harnt.nvim',
    name = 'harnt-nvim',
    lazy = false,
    opts = {},
    keys = {
      { '<leader>ag', '<cmd>Harnt open antigravity<cr>', desc = '[A]ntigravity: Open' },
      { '<leader>at', '<cmd>Harnt toggle antigravity<cr>', desc = '[A]ntigravity: Toggle terminal' },
      { '<leader>as', '<cmd>Harnt send<cr>', mode = { 'n', 'v' }, desc = '[A]ntigravity: Send buffer / selection' },
      { '<leader>ac', '<cmd>Harnt changes<cr>', desc = '[A]ntigravity: Change-log' },
      { '<leader>ah', '<cmd>Harnt health<cr>', desc = '[A]ntigravity: Health check' },
    },
    config = function(_, opts)
      require('harnt').setup(opts)

      -- Restore the last session by default
      require('harnt.providers.antigravity').cmd = { 'agy', '-c' }

      -- Convenient alias command
      vim.api.nvim_create_user_command('Antigravity', function(args)
        if args.args and args.args ~= '' then
          vim.cmd('Harnt ' .. args.args)
        else
          vim.cmd('Harnt open antigravity')
        end
      end, { nargs = '?', desc = 'Open or manage Antigravity agent in Neovim' })

      -- Register which-key group for <leader>a if which-key is loaded
      local ok, wk = pcall(require, 'which-key')
      if ok then
        wk.add {
          { '<leader>a', group = '[A]ntigravity / Agent' },
        }
      end
    end,
  },
}
