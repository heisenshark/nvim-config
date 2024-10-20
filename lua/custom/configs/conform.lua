--type conform.options
local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettier" },
    typescript = { "prettier" },
    typescriptreact = { "prettier" },
    javascriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },

    sh = { "shfmt" },
    ocaml = { "ocamlformat" },
    python = { "ruff", "pyright" },
    csharp = { "ast-grep", "csharpier", "clangformat" },
    ["c#"] = { "ast-grep", "csharpier", "clangformat" },
    ["cs"] = { "csharpier", "clangformat" },
    rust = { "rustfmt" },
    markdown = { "prettier" },
    nix = { "alejandra" },
    -- ["*.cs"] = {"csharpier"},
  },
  -- adding same formatter for multiple filetypes can look too much work for some
  -- instead of the above code you could just use a loop! the config is just a table after all!

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

require("conform").setup(options)
