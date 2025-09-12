return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    lazy = false,
    ft = 'markdown',
    opts = {
      legacy_commands = false,
      attachments = {
        img_folder = 'media/',
      },
      ui = {
        enable = false,
      },
      workspaces = {
        {
          name = 'personal',
          path = '~/repos/obsidianmd/',
        },
      },
      follow_url_func = function(url)
        vim.fn.jobstart { 'xdg-open', url } -- linux
      end,
    },
  },
}
