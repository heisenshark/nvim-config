return {
  {
    {
      'catgoose/nvim-colorizer.lua',
      name = 'nvim-colorizer-lua',
      event = 'BufReadPre',
      lazy = false,
      opts = { -- set to setup table
        options = {
          suppress_deprecation = true,
          parsers = {
            css = true, -- preset: enables names, hex, rgb, hsl, oklch
            tailwind = { enable = true },
          },
          display = {
            mode = 'virtualtext',
            virtualtext = { position = 'after' },
          },
        },
      },
    },
  },
}
