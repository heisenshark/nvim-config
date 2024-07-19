---@type MappingsTable
local M = {}

M.general = {
  n = {
    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      "formatting",
    },
    -- moving lines config
    ["<A-j>"] = { ":m +1<CR>" },
    ["<A-k>"] = { ":m -2<CR>" },
    ["<leader>N"] = { ":AerialNavOpen<CR>" },
    ["<leader>il"] = { ":lua vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())<CR>", "toggle inlay hints" },
    ["<leader>gd"] = { ":DiffviewOpen<CR>", "Open diffview" },
    ["<leader>gD"] = { ":DiffviewClose<CR>", "Open diffview" },
    ["<leader>fr"] = { function()
      require('telescope.builtin').lsp_references()
    end
    , "Open lsp references" },
    ["<leader>C"] = { function()
      if vim.g.toggleNabla == 1 then
        vim.api.nvim_set_option_value("conceallevel", 0, { scope = "global", win = 0 })
        require "nabla".disable_virt()
        vim.g.toggleNabla = 0
      else
        vim.api.nvim_set_option_value("conceallevel", 1, { scope = "global", win = 0 })
        require "nabla".enable_virt({
          autogen = true, -- auto-regenerate ASCII art when exiting insert mode
          silent = true,  -- silents error messages
        })
        vim.g.toggleNabla = 1
      end
    end },
  },
  v = {
    -- moving multiple lines config
    ["<A-j>"] = { ":m '>+1<CR>gv" },
    ["<A-k>"] = { ":m '<-2<CR>gv" },
    -- ["gM"] = {":lua print(vim.api.nvim_get_mode()['mode'])"},
    ["gM"] = { function()
      print(vim.api.nvim_get_mode()['mode'])
      vim.api.nvim_input("10j")
      -- return "10j"
    end },
    [">"] = { ">gv", "indent" },
  },
}
return M
