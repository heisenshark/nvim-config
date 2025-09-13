return {
  {
    'windwp/nvim-ts-autotag',
    config = true,
    lazy = false,
    name = 'ts-autotag.nvim',
    opts = {
      -- Defaults
      enable_close = true, -- Auto close tags
      enable_rename = true, -- Auto rename pairs of tags
      enable_close_on_slash = true, -- Auto close on trailing </
    },
  },
}
