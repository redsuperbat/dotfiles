return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  cmd = { "NullLsEnable", "NullLsDisable" },
  config = function()
    local null_ls = require("null-ls")

    vim.api.nvim_create_user_command("NullLsEnable", function(ctx)
      null_ls.enable({ name = ctx.args })
    end, { desc = "Enable null ls source", nargs = 1 })

    vim.api.nvim_create_user_command("NullLsDisable", function(ctx)
      null_ls.disable({ name = ctx.args })
    end, { desc = "Disable null ls source", nargs = 1 })

    null_ls.setup({
      sources = {
        -- Github actions
        null_ls.builtins.diagnostics.actionlint,
        -- Dockerfile
        null_ls.builtins.diagnostics.hadolint,
        null_ls.builtins.diagnostics.sqlfluff.with({ extra_args = { "--dialect", "postgres" } }),
        null_ls.builtins.diagnostics.rubocop,
        null_ls.builtins.diagnostics.fish,
      },
    })
  end,
}
