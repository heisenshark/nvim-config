local settings_dir = '.settings'

function _debug(table)
  print(vim.inspect(table))
  vim.fn.getchar() -- poczeka na wciśnięcie klawisza
end

function find_file(path, pattern)
  local results = {}
  local cmd = string.format("find %q -type f -iname '*%s*'", path, pattern)
  local handle = io.popen(cmd)
  if handle then
    for file in handle:lines() do
      table.insert(results, file)
    end
    handle:close()
  end
  return results
end

function find_obsidian_dir(path)
  if vim.fn.isdirectory(path .. '/.obsidian') == 1 then
    return path
  end

  local parent = vim.fn.fnamemodify(path, ':h')
  if parent == path then
    return nil
  end
  return find_obsidian_dir(parent)
end

return {
  {
    '3rd/image.nvim',
    dependencies = { 'obsidian.nvim' },
    config = function()
      require('image').setup {
        backend = 'kitty',
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'markdown', 'vimwiki' }, -- markdown extensions (ie. quarto) can go here
            resolve_image_path = function(document_path, image_path, fallback)
              local obsidian_dir = find_obsidian_dir(vim.fn.expand(document_path))
              if obsidian_dir ~= nil then
                f = find_file(obsidian_dir, image_path)
                if f[1] ~= nil then
                  return f[1]
                end
              end
              return fallback(document_path, image_path)
            end,
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { 'norg' },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 40,
        window_overlap_clear_enabled = true, -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = {
          'cmp_menu',
          'cmp_docs',
          'Normal',
          'NormalNC',
          'Comment',
          'Constant',
          'Special',
          'Identifier',
          'Statement',
          'PreProc',
          'Type',
          'Underlined',
          'Todo',
          'String',
          'Function',
          'Conditional',
          'Repeat',
          'Operator',
          'Structure',
          'LineNr',
          'NonText',
          'SignColumn',
          'CursorLine',
          'CursorLineNr',
          'StatusLine',
          'StatusLineNC',
          'EndOfBuffer',
        },
        editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { '*.png', '*.jpg', '*.jpeg', '*.gif', '*.webp' }, -- render image files as images when opened
      }
    end,
    lazy = false,
  },
}
