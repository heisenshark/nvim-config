---@type MappingsTable
local M = {}

M.general = {
  n = {
    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    -- moving lines config
    ["<A-j>"] = { ":m +1<CR>" },
    ["<A-k>"] = { ":m -2<CR>" },
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
