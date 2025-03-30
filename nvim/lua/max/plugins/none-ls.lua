local format_current_buf = function()
  vim.lsp.buf.format({
    async = false,
    filter = function(client)
      local accepted_clients = vim.iter({
        "null-ls",
        "prismals",
        "rust-analyzer",
        "denols",
        "marksman",
        "biome",
      })
      local is_accepted = accepted_clients:any(function(c)
        return c == client.name
      end)

      return is_accepted
    end,
    bufnr = vim.api.nvim_get_current_buf(),
  })
end

return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  cmd = { "NullLsEnable", "NullLsDisable" },
  keys = {
    {
      "<leader>cf",
      format_current_buf,
      mode = { "n" },
      desc = "Format buffer",
    },
  },
  config = function()
    local null_ls = require("null-ls")

    vim.api.nvim_create_user_command("NullLsEnable", function(ctx)
      null_ls.enable({ name = ctx.args })
    end, { desc = "Enable null ls source", nargs = 1 })

    vim.api.nvim_create_user_command("NullLsDisable", function(ctx)
      null_ls.disable({ name = ctx.args })
    end, { desc = "Disable null ls source", nargs = 1 })

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = format_current_buf,
    })

    null_ls.setup({
      sources = {
        null_ls.builtins.diagnostics.actionlint,

        null_ls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
        null_ls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),

        null_ls.builtins.formatting.shfmt,

        null_ls.builtins.formatting.terraform_fmt,

        null_ls.builtins.formatting.rubocop,
        null_ls.builtins.diagnostics.rubocop,

        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.formatting.fish_indent,

        null_ls.builtins.formatting.prettier.with({
          condition = function(utils)
            return utils.root_has_file({
              ".prettierrc",
              ".prettierrc.json",
              ".prettierrc.yml",
              ".prettierrc.yaml",
              ".prettierrc.js",
              ".prettierrc.js",
            })
          end,
        }),
      },
    })
  end,
}
