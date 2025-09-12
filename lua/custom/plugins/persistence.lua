return {
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' },
      -- add any custom options here
    },
  },
}
