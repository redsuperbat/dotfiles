local fs = require("max.utils.fs")
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Neotree",
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("max.utils.fs").root() })
      end,
      desc = "Explorer NeoTree (Root Dir)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (Root Dir)", remap = true },

    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.fn.getcwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
    {
      "<leader>ge",
      function()
        require("neo-tree.command").execute({ source = "git_status", toggle = true })
      end,
      desc = "Git Explorer",
    },
    {
      "<leader>be",
      function()
        require("neo-tree.command").execute({ source = "buffers", toggle = true })
      end,
      desc = "Buffer Explorer",
    },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    if vim.fn.argc(-1) == 1 and fs.is_dir(vim.fn.argv(0)) then
      require("neo-tree")
    end
  end,
  config = function()
    require("neo-tree").setup({
      sources = { "filesystem", "buffers", "git_status", "document_symbols" },
      open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_hidden = false,
          hide_dotfiles = false,
          hide_gitignored = false,
          never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
            ".DS_Store",
            ".git",
          },
        },
      },
      window = {
        mappings = {
          ["<space>"] = "none",
          ["S"] = {
            function(state)
              local path = state.tree:get_node().path
              if not fs.is_dir(path) then
                path = vim.fs.dirname(path)
              end
              require("telescope.builtin").live_grep({ cwd = path })
            end,
          },
          ["F"] = {
            function(state)
              local path = state.tree:get_node().path
              if not fs.is_dir(path) then
                path = vim.fs.dirname(path)
              end
              require("telescope.builtin").find_files({ cwd = path })
            end,
          },
          ["Y"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.fn.setreg("+", path, "c")
              vim.print("copied path " .. path)
            end,
            desc = "Copy Path to Clipboard",
          },
          ["O"] = {
            function(state)
              local path = state.tree:get_node().path
              vim.print("opening path " .. path)
              os.execute("open -R " .. path)
            end,
            desc = "Open with System Application",
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = "",
          expander_expanded = "",
          expander_highlight = "NeoTreeExpander",
        },
      },
    })

    vim.api.nvim_create_autocmd("TermClose", {
      pattern = "*lazygit",
      callback = function()
        if package.loaded["neo-tree.sources.git_status"] then
          require("neo-tree.sources.git_status").refresh()
        end
      end,
    })
  end,
}
