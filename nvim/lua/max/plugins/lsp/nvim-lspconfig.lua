local fs = require("max.utils.fs")

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  dependencies = {
    "antosha417/nvim-lsp-file-operations",
    "saghen/blink.cmp",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {},
  config = function()
    local lspconfig = require("lspconfig")
    local mason_lspconfig = require("mason-lspconfig")

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

    lspconfig.ruby_lsp.setup({
      init_options = {
        formatter = false,
      },
      root_dir = function(filename)
        local is_sorbet_configured = lspconfig.util.root_pattern("sorbet/rbi/gems")(filename)
        -- We do not wanna start this lsp if sorbet is configured in the project
        if is_sorbet_configured ~= nil then
          return nil
        end

        return lspconfig.util.root_pattern("Gemfile")(filename)
      end,
    })

    add_handler("sorbet", {
      cmd = {
        "bundle",
        "exec",
        "srb",
        "tc",
        "--lsp",
        "--disable-watchman",
        vim.fn.getcwd(),
      },
      root_dir = lspconfig.util.root_pattern("sorbet/rbi/gems"),
      init_options = {
        highlightUntyped = true,
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
    vim.lsp.enable("rustproof")
  end,
}
