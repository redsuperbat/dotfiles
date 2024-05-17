return {
  "sindrets/diffview.nvim",
  config = function(config)
    vim.keymap.set(
      { "n", "v" },
      "<leader>gld",
      "<Cmd>.DiffviewFileHistory --follow<CR>",
      { desc = "File history for the current line" }
    )
    vim.keymap.set(
      { "n", "v" },
      "<leader>gfd",
      "<Cmd>DiffviewFileHistory %<CR>",
      { desc = "File history for the current line" }
    )

    return config
  end,
}
