local fs = require("max.utils.fs")
return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "antosha417/nvim-lsp-file-operations",
    "folke/lazydev.nvim",
    "saghen/blink.cmp",
    "williamboman/mason-lspconfig.nvim",
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
          require("telescope.builtin").lsp_definitions({ no_ignore = true })
        end, opts)

        opts.desc = "Go to references"
        keymap("n", "gr", "<cmd>Telescope lsp_references<cr>", opts)

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
        keymap({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

        opts.desc = "Rename"
        keymap("n", "<leader>cr", vim.lsp.buf.rename, opts)

        opts.desc = "Run code lens"
        keymap("n", "<leader>cc", vim.lsp.codelens.run, opts)

        opts.desc = "Restart LSP"
        keymap("n", "<leader>rs", ":LspRestart<CR>", opts)
      end,
    })

    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      require("lsp-file-operations").default_capabilities(),
      require("blink.cmp").get_lsp_capabilities()
    )

    local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
    end

    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

    ---@param server_name string
    local setup_server = function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
      })
    end

    local handlers = {
      -- default handler for installed servers
      setup_server,
    }

    local add_handler = function(name, options)
      local setup = vim.tbl_deep_extend("error", { capabilities = capabilities }, options or {})
      handlers[name] = function()
        lspconfig[name].setup(setup)
      end
    end

    add_handler("jsonls", {
      settings = {
        json = {
          format = {
            enable = false,
          },
        },
        validate = { enable = true },
      },
    })

    add_handler("denols", {
      root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
      single_file_support = false,
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
    })

    add_handler("biome", {
      filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
      },
    })

    add_handler("tailwindcss", {
      filetypes = {
        "typescript.tsx",
        "typescriptreact",
        "svelte",
        "vue",
        "html",
      },
    })

    add_handler("ts_ls", {
      filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact" },
      --- @param filename string
      --- @param bufnr number
      root_dir = function(filename, bufnr)
        local files_to_not_start_lsp = {
          "deno.json",
        }
        for _, f_name in ipairs(files_to_not_start_lsp) do
          if fs.find_file(f_name, bufnr) then
            return nil
          end
        end

        return lspconfig.util.root_pattern("package.json")(filename)
      end,
      single_file_support = false,
      commands = {
        OrganizeImports = {
          function()
            local params = {
              command = "_typescript.organizeImports",
              arguments = { vim.api.nvim_buf_get_name(0) },
              title = "Organize Imports",
            }
            vim.lsp.buf.execute_command(params)
          end,
          description = "Organize Imports",
        },
      },
    })

    add_handler("volar", {
      filetypes = { "vue" },
      root_dir = lspconfig.util.root_pattern("app.vue"),
      init_options = {
        vue = {
          hybridMode = false,
        },
        typescript = {
          tsdk = vim.fn.getcwd() .. "/node_modules/typescript/lib",
        },
      },
    })

    add_handler("docker_compose_language_service", {
      filetypes = {
        "yaml",
      },
    })

    setup_server("nushell")

    add_handler("lua_ls", {
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

    mason_lspconfig.setup_handlers(handlers)
  end,
}
