local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
    opts = {
      -- inlay_hints = {enabled = true},
      inlay_hints = { enabled = true },
    },
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  {
    "xiyaowong/transparent.nvim",
    lazy = false,
    extra_groups = {},
  },
  { "akinsho/git-conflict.nvim", version = "*", config = true, lazy = false },
  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  {
    "stevearc/conform.nvim",
    --  for users those who want auto-save conform + lazyloading!
    -- event = "BufWritePre"
    lazy = false,
    config = function()
      require "custom.configs.conform"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-angular",
    lazy = false,
  },
  {
    "Hoffs/omnisharp-extended-lsp.nvim",
    lazy = false,
  },
  {
    "smoka7/multicursors.nvim",
    event = "VeryLazy",
    dependencies = {
      "smoka7/hydra.nvim",
    },
    opts = {},
    cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
    keys = {
      {
        mode = { "v", "n" },
        "<Leader>mm",
        "<cmd>MCunderCursor<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
    normal_keys = {
      [","] = {
        -- method = N.clear_others,
        opts = { desc = "Clear others" },
      },
    },
    config = function(_, opts)
      local N = require "multicursors.normal_mode"
      local I = require "multicursors.insert_mode"
      local mcsel = require "multicursors.selections"
      require("multicursors").setup {
        normal_keys = {
          -- to change default lhs of key mapping change the key
          ["<C-/>"] = {
            method = function()
              require("multicursors.utils").call_on_selections(function(selection)
                vim.api.nvim_win_set_cursor(0, { selection.row + 1, selection.col + 1 })
                local line_count = selection.end_row - selection.row + 1
                vim.cmd("normal " .. line_count .. "gcc")
              end)
            end,
            opts = { desc = "comment selections" },
          },
        },
        insert_keys = {
          ["<C-h>"] = {
            method = I.Left_method,
            opts = { desc = "move left" },
          },
          ["<C-l>"] = {
            method = I.Right_method,
            opts = { desc = "move right" },
          },
          ["<C-u>"] = {
            method = function()
              mcsel.move_by_motion("b")
            end,
            opts = { desc = "move word left" },
          },
          ["<C-i>"] = {
            method = function()
              mcsel.move_by_motion("E")
            end,
            opts = { desc = "move word right" },
          },
        },
      }
    end,
    lazy = false,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^4", -- Recommended
    ft = { "rust" },
    lazy = false,
    enabled = false,
  },
  {
    "sindrets/diffview.nvim",
    lazy = true,
    cmd = { "DiffviewOpen" },
  },
  {
    "alec-gibson/nvim-tetris",
    lazy = false,
  },
  {
    "elkowar/yuck.vim",
    lazy = false,
  },
  {
    "eraserhd/parinfer-rust",
    lazy = false,
  },
  {
    "vhyrro/luarocks.nvim",
    priority = 1001, -- this plugin needs to run before anything else
    opts = {
      rocks = { "magick" },
    },
  },
  {
    "3rd/image.nvim",
    dependencies = { "luarocks.nvim" },
    config = function()
      require("image").setup {
        backend = "kitty",
        integrations = {
          markdown = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "markdown", "vimwiki" }, -- markdown extensions (ie. quarto) can go here
          },
          neorg = {
            enabled = true,
            clear_in_insert_mode = false,
            download_remote_images = true,
            only_render_image_at_cursor = false,
            filetypes = { "norg" },
          },
        },
        max_width = nil,
        max_height = nil,
        max_width_window_percentage = nil,
        max_height_window_percentage = 50,
        window_overlap_clear_enabled = false,                                     -- toggles images when windows are overlapped
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        editor_only_render_when_focused = false,                                  -- auto show/hide images when the editor gains/looses focus
        tmux_show_only_in_active_window = false,                                  -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
      }
    end,
    lazy = false,
  },
  -- {
  --   "startup-nvim/startup.nvim",
  --   requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
  --   config = function()
  --     require"startup".setup(require"startup.functions")
  --   end,
  --   lazy=false
  -- }
  --
  --
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    opts = function()
      local logo = [[
         ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
         ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z
         ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z
         ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z
         ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
         ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
    ]]

      logo = string.rep("\n", 8 + 6) .. "\n\n"

      local api = require "image"

      local logo_path = vim.api.nvim_get_runtime_file("lua/startup/NeoVimLogo.png", false)[1]
      img = api.from_file(logo_path, {
        window = 1000,
        buffer = vim.api.nvim_buf_get_number(0),
        inline = false,
        width = 40,
      })
      local opts = {
        theme = "doom",
        hide = {
          statusline = true,
        },
        config = {
          header = vim.split(logo, "\n"),
          center = {
            -- { action = LazyVim.telescope("files"),                                    desc = " Find File",       icon = " ", key = "f" },
            {
              action = "ene",
              desc = " New File",
              icon = " ",
              key = "n",
            },
            {
              action = "Telescope oldfiles",
              desc = " Recent Files",
              icon = " ",
              key = "r",
            },
            {
              action = "Telescope live_grep",
              desc = " Find Text",
              icon = " ",
              key = "g",
            },
            {
              action = function()
                local function press_keys(keys)
                  -- Użyj funkcji nvim_feedkeys do symulacji naciśnięcia klawiszy
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, true, true), 'n', true)
                end
                vim.cmd("cd ~/.config/nvim/")
                vim.cmd("NvimTreeOpen")
                press_keys("<Tab><S-Tab>")
                -- vim.api.nvim_eval("")
              end,
              desc = " Config",
              icon = " ",
              key = "c",
            },
            {
              action = function()
                require("persistence").load()
                -- require("nvchad.statusline.default").run()
              end,
              desc = " Restore Session",
              icon = " ",
              key = "s",
            },
            {
              action = "LazyExtras",
              desc = " Lazy Extras",
              icon = " ",
              key = "x",
            },
            {
              action = "Lazy",
              desc = " Lazy",
              icon = "󰒲 ",
              key = "l",
            },
            {
              action = "qa",
              desc = " Quit",
              icon = " ",
              key = "q",
            },
          },
          footer = function()
            local stats = require("lazy").stats()
            local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
            local dupa = vim.api.nvim_win_get_width(0)
            img.buffer = vim.api.nvim_buf_get_number(0)
            print(dupa)
            img:clear()
            img:render()
            img:move(math.floor(dupa / 2) - 20, 2)
            return { "⚡ Neovim loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms .. "ms" }
          end,
        },
      }

      for _, button in ipairs(opts.config.center) do
        button.desc = button.desc .. string.rep(" ", 10 - #button.desc)
        button.key_format = "  %s"
      end

      -- close Lazy and re-open when the dashboard is ready
      if vim.o.filetype == "lazy" then
        vim.cmd.close()
        vim.api.nvim_create_autocmd("User", {
          pattern = "DashboardLoaded",
          callback = function()
            require("lazy").show()
          end,
        })
      end
      -- uv.run() --it will hold at this point until every timer have finished
      return opts
    end,
    lazy = false,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
    lazy = false,
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre", -- this will only start session saving when an actual file was opened
    opts = {
      options = { "buffers", "curdir", "tabpages", "winsize" },
      -- add any custom options here
    }
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
    lazy = false,
  },
  {
    'vidocqh/data-viewer.nvim',
    opts = {},
    dependencies = {
      "nvim-lua/plenary.nvim",
      "kkharji/sqlite.lua", -- Optional, sqlite support
    },
    lazy = false,
  },
  {
    'stevearc/aerial.nvim',
    opts = {},
    -- Optional dependencies
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons"
    },
    config = function()
      require 'aerial'.setup()
    end,
    lazy = false,
  },
  {
    "luckasRanarison/tailwind-tools.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {}, -- your configuration
    lazy = false,
  },
  {
    "onsails/lspkind.nvim",
    lazy = false,
  },

  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    lazy = false,
  },
  {
    "gerazov/ollama-chat.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "stevearc/dressing.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = {
      "OllamaQuickChat",
      "OllamaCreateNewChat",
      "OllamaContinueChat",
      "OllamaChat",
      "OllamaChatCode",
      "OllamaModel",
      "OllamaServe",
      "OllamaServeStop"
    },

    keys = {
      {
        "<leader>ocq",
        "<cmd>OllamaQuickChat<cr>",
        desc = "Ollama Quick Chat",
        mode = { "n", "x" },
        silent = true,
      },
      {
        "<leader>ocn",
        "<cmd>OllamaCreateNewChat<cr>",
        desc = "Create Ollama Chat",
        mode = { "n", "x" },
        silent = true,
      },
      {
        "<leader>occ",
        "<cmd>OllamaContinueChat<cr>",
        desc = "Continue Ollama Chat",
        mode = { "n", "x" },
        silent = true,
      },
      {
        "<leader>och",
        "<cmd>OllamaChat<cr>",
        desc = "Chat",
        mode = { "n" },
        silent = true,
      },
      {
        "<leader>ocd",
        "<cmd>OllamaChatCode<cr>",
        desc = "Chat Code",
        mode = { "n" },
        silent = true,
      },
    },

    opts = {
      chats_folder = vim.fn.stdpath("data"), -- data folder is ~/.local/share/nvim
      -- you can also choose "current" and "tmp"
      quick_chat_file = "ollama-chat.md",
      animate_spinner = true, -- set this to false to disable spinner animation
      model = "llama3",
      model_code = "codellama",
      url = "http://127.0.0.1:11434",
      serve = {
        on_start = false,
        command = "ollama",
        args = { "serve" },
        stop_command = "pkill",
        stop_args = { "-SIGTERM", "ollama" },
      },
    },
    {
      "supermaven-inc/supermaven-nvim",
      config = function()
        require("supermaven-nvim").setup({
          keymaps = {
            accept_suggestion = "<C-a>",
            clear_suggestion = "<C-]>",
            accept_word = "<C-s>",
          },
          ignore_filetypes = { cpp = true },
          color = {
            suggestion_color = "#ffffff",
            cterm = 244,
          },
          disable_inline_completion = false, -- disables inline completion for use with cmp
          disable_keymaps = false    -- disables built in keymaps for more manual control
        })
      end,
      lazy = false,
    },
  }

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
}

return plugins
