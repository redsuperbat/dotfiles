---@diagnostic disable: missing-fields

return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Runners
    "olimorris/neotest-rspec",
    "nvim-neotest/neotest-jest",
    "rouge8/neotest-rust",
  },
  event = "VeryLazy",
  config = function()
    require("neotest").setup({
      adapters = {
        require("neotest-rspec"),
        require("neotest-jest"),
        require("neotest-rust"),
      },
    })
    vim.keymap.set("n", "<leader>tt", function()
      require("neotest").run.run()
    end, { desc = "Run test under cursor" })

    vim.keymap.set("n", "<leader>ta", function()
      require("neotest").run.attach()
    end, { desc = "Attach to nearest test" })

    vim.keymap.set("n", "<leader>tf", function()
      require("neotest").run.run(vim.fn.expand("%"))
    end, { desc = "Run all test in current buffer" })
  end,
}
