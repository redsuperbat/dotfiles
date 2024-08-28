return {
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  "nvimtools/none-ls.nvim",
  config = function()
    local nls = require("null-ls")
    nls.setup()
    nls.builtins.formatting.biome.with({
      args = {
        "check",
        "--apply-unsafe",
        "--skip-errors",
        "--formatter-enabled=true",
        "--organize-imports-enabled=true",
        "$FILENAME",
      },
    })
  end,
}
