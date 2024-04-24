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
        "<Leader>m",
        "<cmd>MCstart<cr>",
        desc = "Create a selection for selected text or word under the cursor",
      },
    },
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
    lazy=true,
    cmd ={"DiffviewOpen"}
  },
  {
    "alec-gibson/nvim-tetris",
    lazy=false,
  },
  {
    "elkowar/yuck.vim",
    lazy=false,
  },
  {
   "eraserhd/parinfer-rust",
    lazy=false
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
        require("image").setup({
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
          window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
          window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
          editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
          tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
          hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" }, -- render image files as images when opened
        })
      end,
    lazy = false
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

    logo = string.rep("\n", 8+6) .. "\n\n"

    local api = require("image")
    
    local logo_path = vim.api.nvim_get_runtime_file("lua/startup/NeoVimLogo.png", false)[1]
    img = api.from_file(logo_path,{
    window = 1000,
    buffer = vim.api.nvim_buf_get_number(0),
    inline = false,
    width = 40,
    })
    local opts = {
      theme = "doom",
      hide = {
        statusline = true ,
      },
      config = {
        header = vim.split(logo, "\n"),
        center = {
          -- { action = LazyVim.telescope("files"),                                    desc = " Find File",       icon = " ", key = "f" },
          { action = "ene | startinsert",                                        desc = " New File",        icon = " ", key = "n" },
          { action = "Telescope oldfiles",                                       desc = " Recent Files",    icon = " ", key = "r" },
          { action = "Telescope live_grep",                                      desc = " Find Text",       icon = " ", key = "g" },
          { action = [[lua LazyVim.telescope.config_files()()]], desc = " Config",          icon = " ", key = "c" },
          { action = 'lua require("persistence").load()',                        desc = " Restore Session", icon = " ", key = "s" },
          { action = "LazyExtras",                                               desc = " Lazy Extras",     icon = " ", key = "x" },
          { action = "Lazy",                                                     desc = " Lazy",            icon = "󰒲 ", key = "l" },
          { action = "qa",                                                       desc = " Quit",            icon = " ", key = "q" },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local dupa = vim.api.nvim_win_get_width(0)
          img.buffer = vim.api.nvim_buf_get_number(0)
          print(dupa)
          img:clear()
          img:render()
          img:move(math.floor(dupa / 2)-20,2)
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
        lazy= false,
    },
    {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = true,
    lazy=false,
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
