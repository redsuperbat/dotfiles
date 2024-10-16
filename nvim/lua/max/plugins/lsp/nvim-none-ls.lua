local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({
    async = false,
    filter = function(client)
      local accepted_clients = vim.iter({ "null-ls", "prismals", "rust_analyzer" })
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
    local nls = require("null-ls")
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

    nls.setup({
      sources = {
        nls.builtins.code_actions.refactoring,

        nls.builtins.diagnostics.actionlint,

        cspell.diagnostics.with({
          config = cspell_config,
          diagnostics_postprocess = function(diagnostic)
            diagnostic.severity = vim.diagnostic.severity.HINT
          end,
        }),
        cspell.code_actions.with({ config = cspell_config }),

        nls.builtins.formatting.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),
        nls.builtins.diagnostics.sqlfluff.with({
          extra_args = { "--dialect", "postgres" },
        }),

        nls.builtins.formatting.shfmt,

        nls.builtins.formatting.terraform_fmt,

        nls.builtins.formatting.stylua,
        nls.builtins.formatting.biome.with({
          args = {
            "check",
            "--write",
            "--stdin-file-path",
            "$FILENAME",
          },
        }),

        nls.builtins.diagnostics.fish,
        nls.builtins.formatting.fish_indent,

        nls.builtins.formatting.prettier.with({
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
