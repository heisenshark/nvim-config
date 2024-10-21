local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  -- "tsserver",
  "clangd",
  "ocamllsp",
  "angularls",
  "pyright",
  "gopls",
  "rust_analyzer",
  "sqlls",
  "zls",
  "nixd",
}

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- lspconfig["digestif"].setup{
--   cmd = {"digestif"},
--   filetypes = {"tex", "plaintex", "context","markdown"},
--   on_attach = on_attach,
--   capabilities = capabilities,
-- }

-- lspconfig["ltex"].setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   use_spellfile = false,
--   filetypes = { "latex", "tex", "bib", "markdown", "gitcommit", "text" },
--   settings = {
--     ltex = {
--       enabled = { "latex", "tex", "bib", "markdown" },
--       language = "auto",
--       diagnosticSeverity = "information",
--       sentenceCacheSize = 2000,
--       additionalRules = {
--         enablePickyRules = true,
--         motherTongue = "fr",
--       },
--       disabledRules = {
--         fr = { "APOS_TYP", "FRENCH_WHITESPACE" },
--       },
--       dictionary = (function()
--         -- For dictionary, search for files in the runtime to have
--         -- and include them as externals the format for them is
--         -- dict/{LANG}.txt
--         --
--         -- Also add dict/default.txt to all of them
--         local files = {}
--         for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
--           local lang = vim.fn.fnamemodify(file, ":t:r")
--           local fullpath = vim.fs.normalize(file, ":p")
--           files[lang] = { ":" .. fullpath }
--         end
--
--         if files.default then
--           for lang, _ in pairs(files) do
--             if lang ~= "default" then
--               vim.list_extend(files[lang], files.default)
--             end
--           end
--           files.default = nil
--         end
--         return files
--       end)(),
--     },
--   },
-- }

lspconfig.texlab.setup {
  cache_activate = true,
  cache_filetypes = { "tex", "bib", "md", "markdown" },
  cache_root = vim.fn.stdpath "cache",
  reverse_search_start_cmd = function()
    return true
  end,
  reverse_search_edit_cmd = vim.cmd.edit,
  reverse_search_end_cmd = function()
    return true
  end,
  file_permission_mode = 438,
  filetypes = { "markdown" },
}

lspconfig.emmet_language_server.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = { "emmet-language-server", "--stdio" },
  filetypes = {
    "css",
    "eruby",
    "html",
    "javascript",
    "javascriptreact",
    "less",
    "sass",
    "scss",
    "svelte",
    "pug",
    "typescriptreact",
    "vue",
  },
  init_options = {
    html = {
      options = {
        -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
        ["bem.enabled"] = true,
      },
    },
    showSuggestionsAsSnippets = false,
  },
  single_file_support = true,
}
--
-- lspconfig.pyright.setup { blabla}
--
local pid = vim.fn.getpid()
-- On linux/darwin if using a release build, otherwise under scripts/OmniSharp(.Core)(.cmd)
local omnisharp_bin = vim.fn.expand "$HOME/.local/share/nvim/mason/packages/omnisharp/omnisharp"

lspconfig["omnisharp"].setup {
  cmd = { omnisharp_bin, "--languageserver", "--hostPID", tostring(pid) },
  handlers = {
    ["textDocument/definition"] = require("omnisharp_extended").definition_handler,
    ["textDocument/references"] = require("omnisharp_extended").references_handler,
    ["textDocument/implementation"] = require("omnisharp_extended").implementation_handler,
  },
  capabilities = capabilities,
  on_attach = on_attach,
}

lspconfig.eslint.setup {};

lspconfig["biome"].setup {
  cmd = { "biome", "lsp-proxy" },
  filetypes = {
    "javascript",
    "javascriptreact",
    "json",
    "jsonc",
    "typescript",
    "typescript.tsx",
    "typescriptreact",
    "astro",
    "svelte",
    "vue",
  },
  root_dir = require("lspconfig.util").root_pattern("biome.json", "biome.jsonc"),
  single_file_support = false,
}

local mason_registry = require('mason-registry')
local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() ..
    '/node_modules/@vue/language-server'

lspconfig["ts_ls"].setup {
  filetypes = { "vue", "typescript", "javascript", "typescriptreact", "javascriptreact", "angular", "html" },
  -- plugins = {
  --   {
  --     name = "@vue/typescript-plugin",
  --     location = vue_language_server_path,
  --     languages = { "javascript", "typescript", "vue" },
  --   },
  -- },
  init_options = {
    preferences = {
      includeInlayParameterNameHints = 'all',
      includeInlayParameterNameHintsWhenArgumentMatchesName = true,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true,
      importModuleSpecifierPreference = 'non-relative',
    }
  }
}

-- lspconfig["volar"].setup {
--   filetypes = { "vue", "typescript", "javascript" },
--   init_options = {
--     vue = {
--       hybridMode = false,
--     },
--   }
-- }


lspconfig["rust_analyzer"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      procMacro = { enable = true },
      cargo = { allFeatures = true },
      checkOnSave = {
        command = "clippy",
        extraArgs = { "--no-deps" },
      },
    },
  },
}

lspconfig["tailwindcss"].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
}
