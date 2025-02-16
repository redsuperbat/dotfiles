return {
  { "rafamadriz/friendly-snippets", lazy = true },
  {
    "saghen/blink.cmp",
    event = { "VeryLazy" },
    version = "v0.*",
    config = function()
      require("blink.cmp").setup({
        enabled = function()
          -- Disable in code-actions and code-renames
          local disabled_filetypes = {
            "DressingInput",
            "snacks_picker_input",
            "neo-tree-popup",
          }
          return not vim.tbl_contains(disabled_filetypes, vim.bo.filetype)
        end,
        keymap = {
          preset = "default",
          ["<CR>"] = { "select_and_accept", "fallback" },
        },
        cmdline = {
          keymap = {
            ["<S-Tab>"] = { "select_prev", "fallback" },
            ["<Tab>"] = { "select_next", "fallback" },
          },
        },
        sources = {
          default = { "lsp", "path", "snippets", "buffer", "codecompanion", "markdown" },
          providers = {
            markdown = {
              name = "RenderMarkdown",
              module = "render-markdown.integ.blink",
            },
            codecompanion = {
              name = "CodeCompanion",
              module = "codecompanion.providers.completion.blink",
            },
            lsp = {
              min_keyword_length = 0, -- Number of characters to trigger provider
              score_offset = 0, -- Boost/penalize the score of the items
            },
            path = {
              min_keyword_length = 0,
            },
            snippets = {
              min_keyword_length = 1,
            },
            buffer = {
              min_keyword_length = 5,
              max_items = 5,
            },
          },
        },
        appearance = {
          kind_icons = {
            Text = "󰉿",
            Method = "",
            Function = "󰊕",
            Constructor = "󰒓",

            Field = "󰜢",
            Variable = "󰆦",
            Property = "󰖷",

            Class = "",
            Interface = "",
            Struct = "",
            Module = "󰅩",

            Unit = "󰪚",
            Value = "󰦨",
            Enum = "",
            EnumMember = "󰦨",

            Keyword = "󰻾",
            Constant = "󰏿",

            Snippet = "󱄽",
            Color = "󰏘",
            File = "󰈔",
            Reference = "󰬲",
            Folder = "󰉋",
            Event = "󱐋",
            Operator = "󰪚",
            TypeParameter = "󰬛",
          },
          nerd_font_variant = "mono",
        },
        completion = {
          menu = {
            border = "rounded",
            draw = {
              columns = {
                {
                  "kind_icon",
                  "label",
                  gap = 2,
                },
                {
                  "label_description",
                  gap = 5,
                  "kind",
                },
              },
            },
          },
          documentation = {
            auto_show = true,
            auto_show_delay_ms = 250,
            treesitter_highlighting = true,
            window = { border = "rounded" },
          },
        },
        signature = { enabled = true, window = { border = "rounded" } },
      })
      require("max.utils.theme").set_bg({
        "BlinkCmpMenu",
        "BlinkCmpDoc",
        "BlinkCmpDocSeparator",
        "BlinkCmpDocBorder",
        "BlinkCmpMenuBorder",
      })
    end,
  },
}
