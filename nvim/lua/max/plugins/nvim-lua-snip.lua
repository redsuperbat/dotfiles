return {
  "L3MON4D3/LuaSnip",
  event = { "InsertEnter" },
  dependencies = {
    "rafamadriz/friendly-snippets",
    "saadparwaiz1/cmp_luasnip",
  },
  config = function()
    local luasnip = require("luasnip")

    -- Add html snippets in jsx, tsx and vue
    luasnip.filetype_extend("javascriptreact", { "html" })
    luasnip.filetype_extend("typescriptreact", { "html" })
    luasnip.filetype_extend("vue", { "html" })

    require("luasnip").setup({
      history = true,
      delete_check_events = "TextChanged",
    })

    require("luasnip.loaders.from_vscode").lazy_load()
  end,
}
