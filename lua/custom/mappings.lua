---@type MappingsTable
local M = {}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<A-j>"] = { "ddp" },
    ["<A-k>"] = { "ddkP" },
  },
  v = {
    ["<A-k>"] = { "dkPV`[`]" },
    ["<A-j>"] = { "dpV`[`]" },
    -- ["gM"] = {":lua print(vim.api.nvim_get_mode()['mode'])"},
    ["gM"] = { function()
      print(vim.api.nvim_get_mode()['mode'])
      return "10j"
    end },
    [">"] = { ">gv", "indent" },
  },
}

return M
