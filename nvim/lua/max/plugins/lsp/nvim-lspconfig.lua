local logger = require("plenary.log").new({
  plugin = "lspconfig",
})

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  opts = {},
  config = function()
    local keymap = vim.keymap.set

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        local opts = { buffer = ev.buf, silent = true }
        opts.desc = "Lsp Info"
        keymap("n", "<leader>cl", "<cmd>LspInfo<cr>", opts)

        opts.desc = "Go to definition"
        keymap("n", "gd", function()
          require("telescope.builtin").lsp_definitions({ reuse_win = true })
        end, opts)

        opts.desc = "Go to references"
        keymap("n", "<leader>cl", "<cmd>Telescope lsp_references<cr>", opts)

        opts.desc = "Go to declaration"
        keymap("n", "gD", vim.lsp.buf.declaration, opts)

        opts.desc = "Go to implementations"
        keymap("n", "gi", function()
          require("telescope.builtin").lsp_implementations({ reuse_win = true })
        end, opts)

        opts.desc = "Go to type definitions"
        keymap("n", "gy", function()
          require("telescope.builtin").lsp_type_definitions({ reuse_win = true })
        end, opts)

        opts.desc = "Signature help"
        keymap("n", "gK", vim.lsp.buf.signature_help, opts)

        opts.desc = "Code action"
        keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Rename"
        keymap("n", "<leader>cr", vim.lsp.buf.rename, opts)

        opts.desc = "Run code lens"
        keymap("n", "<leader>cc", vim.lsp.codelens.run, opts)

        opts.desc = "Restart LSP"
        keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local capabilities =
      vim.tbl_deep_extend("force", {}, vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup_handlers({
      -- default handler for installed servers
      function(server_name)
        lspconfig[server_name].setup({
          capabilities = capabilities,
        })
      end,
      ["jsonls"] = function()
        lspconfig["jsonls"].setup({
          capabilities = capabilities,
          settings = {
            json = {
              format = {
                enable = true,
              },
            },
            validate = { enable = true },
          },
        })
      end,
      ["lua_ls"] = function()
        lspconfig["lua_ls"].setup({
          capabilities = capabilities,
          settings = {
            Lua = {
              diagnostics = {
                globals = { "vim" },
              },
              workspace = {
                checkThirdParty = false,
              },
              codeLens = {
                enable = true,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        })
      end,
    })
  end,
}
