local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    async = false,
    filter = function(client)
      local accepted_clients = vim.iter({ "null-ls", "prismals", "rust_analyzer", "denols" })
      local is_accepted = accepted_clients:any(function(c)
        return c == client.name
      end)

      return is_accepted
    end,
    bufnr = bufnr,
  })
end

return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "davidmh/cspell.nvim",
  },
  keys = {
    {
      "<leader>cf",
      function()
        lsp_formatting(vim.api.nvim_get_current_buf())
      end,
      mode = { "n" },
      desc = "Format buffer",
    },
  },
  config = function()
    local null_ls = require("null-ls")
    local cspell = require("cspell")

    vim.api.nvim_create_autocmd("BufWritePre", {
      callback = function()
        lsp_formatting(vim.api.nvim_get_current_buf())
      end,
    })

    local cspell_config = {
      cspell_config_dirs = { "~/.config/nvim/lua/max/plugins/lsp/cspell/" },
      on_add_to_json = function(payload)
        local command = string.format(
          "jq -S '.words |= sort' %s | sponge %s ",
          payload.cspell_config_path,
          payload.cspell_config_path
        )
        os.execute(command)
      end,
    }

    null_ls.setup({
      sources = {
        null_ls.builtins.code_actions.refactoring,

        null_ls.builtins.diagnostics.actionlint,

        cspell.diagnostics.with({
          config = cspell_config,
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        }),
        cspell.code_actions.with({ config = cspell_config }),

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
        null_ls.builtins.formatting.biome.with({
          args = {
            "check",
            "--write",
            "--stdin-file-path",
            "$FILENAME",
          },
        }),

        null_ls.builtins.diagnostics.fish,
        null_ls.builtins.formatting.fish_indent,

        null_ls.builtins.formatting.prettier.with({
          -- Exclude js/ts json because biome handles that
          disabled_filetypes = {
            "javascript",
            "typescript",
            "javascriptreact",
            "typescriptreact",
            "json",
            "jsonc",
          },
        }),
      },
    })
  end,
}
