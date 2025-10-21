local function is_dir(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == 'directory'
end

local home = os.getenv 'HOME'
local workspace, enabled
if is_dir(home .. '/repos/obsidianmd/') then
  workspace = {
    name = 'personal',
    path = home .. '/repos/obsidianmd/',
  }
else
  return {}
end

return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*', -- recommended, use latest release instead of latest commit
    enabled = is_dir(home .. '/repos/obsidianmd/'),
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
        workspace,
      },
      follow_url_func = function(url)
        vim.fn.jobstart { 'xdg-open', url } -- linux
      end,
    },
  },
}
