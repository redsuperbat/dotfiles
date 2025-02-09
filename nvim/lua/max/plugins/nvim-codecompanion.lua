return {
  { "nvim-lua/plenary.nvim", lazy = true },
  { "nvim-treesitter/nvim-treesitter", lazy = true },
  {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    config = function()
      require("codecompanion").setup({
        adapters = {
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:cat ~/.secrets/openai-api-key",
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "openai",
          },
          inline = {
            adapter = "openai",
          },
        },
        opts = {
          log_level = "DEBUG",
        },
      })

      vim.keymap.set({ "n", "v" }, "<leader>aa", "<cmd>CodeCompanionActions<cr>", {
        desc = "Code companion actions",
        silent = true,
        noremap = true,
      })
      vim.keymap.set({ "n", "v" }, "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", {
        noremap = true,
        silent = true,
        desc = "Toggle code companion chat",
      })
      vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cab cc CodeCompanion]])
    end,
  },
}
