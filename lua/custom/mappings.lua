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
