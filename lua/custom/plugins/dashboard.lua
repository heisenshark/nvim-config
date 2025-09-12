return {
  {
    'nvimdev/dashboard-nvim',
    dependencies = { '3rd/image.nvim' },
    event = 'VimEnter',
    opts = function()
      local logo = [[
      d
    ]]

      logo = string.rep('\n', 8 + 6) .. '\n\n'

      local api = require 'image'

      local logo_path = vim.api.nvim_get_runtime_file('NeoVimLogo.png', false)[1]
      img = api.from_file(logo_path, {
        window = 1000,
        buffer = vim.api.nvim_buf_get_number(0),
        inline = false,
        width = 40,
      })
      local opts = {
        hide = {
          statusline = true,
        },
        theme = 'hyper',
        config = {
          header = vim.split(logo, '\n'),
          center = {
            {
              action = 'ene',
              desc = ' New File',
              icon = ' ',
              key = 'n',
            },
            {
              action = function()
                vim.cmd 'cd ~/.config/nvim/'
                vim.cmd 'Neotree float toggle'
                -- vim.api.nvim_eval("")
              end,
              desc = ' Config',
              icon = ' ',
              key = 'c',
            },
            {
              action = 'qa',
              desc = ' Quit',
              icon = ' ',
              key = 'q',
            },
          },
          footer = function()
            local stats = require('lazy').stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local dupa = vim.api.nvim_win_get_width(0)
            img.buffer = vim.api.nvim_buf_get_number(0)
            print(dupa)
            img:clear()
            img:render()
            img:move(math.floor(dupa / 2) - 20, 2)
            return { '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. 'ms' }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(' ', 10 - #button.desc)
        button.key_format = '  %s'
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == 'lazy' then
        vim.cmd.close()
        vim.api.nvim_create_autocmd('User', {
          pattern = 'DashboardLoaded',
          callback = function()
            require('lazy').show()
          end,
        })
      end
      -- uv.run() --it will hold at this point until every timer have finished
      return opts
    end,
    lazy = false,
  },
}
