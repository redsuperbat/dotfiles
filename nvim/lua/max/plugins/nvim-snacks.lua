--- @type number|false|snacks.win.Backdrop Opacity of the backdrop (default: 60)
local backdrop = false
return {
  "folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      sources = {
        files = {
          hidden = true,
        },
      },
      layout = {
        layout = {
          box = "horizontal",
          backdrop = false,
          width = 0.8,
          min_width = 120,
          height = 0.8,
          {
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            backdrop = {
              bg = "#FFFFFF",
            },
            {
              win = "input",
              height = 1,
              border = "bottom",
            },
            {
              win = "list",
              border = "none",
            },
          },
          {
            win = "preview",
            title = "{preview}",
            border = "rounded",
            width = 0.5,
          },
        },
      },
    },
    gitbrowse = {},
    lazygit = {},
  },
  init = function()
    --- @param group string
    local function set_hl(group)
      vim.api.nvim_set_hl(0, group, { bg = "#1f1f28" })
    end
    set_hl("SnacksPickerFile")
    set_hl("SnacksPickerList")
    set_hl("SnacksPickerCode")
    set_hl("SnacksPickerInput")
    set_hl("SnacksPickerInputSearch")
    set_hl("SnacksPickerBorder")
    set_hl("SnacksPickerBoxBorder")
    set_hl("SnacksPickerListBorder")
    set_hl("SnacksPickerInputBorder")
    set_hl("SnacksPickerPreview")
    set_hl("SnacksPickerPreviewBorder")
    set_hl("SnacksPickerPreviewCursorLine")
    set_hl("SnacksPickerPreviewFooter")
    set_hl("SnacksPickerPreviewTitle")
  end,
  keys = {
    {
      "<leader>go",
      function()
        require("snacks").gitbrowse.open()
      end,
      desc = "Open file on github",
    },
    {
      "<leader>fb",
      function()
        require("snacks").picker.buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>sG",
      function()
        require("max.picker").grep({ cwd = require("max.utils.fs").root() })
      end,
      desc = "Grep",
    },
    {
      "<leader>:",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader><space>",
      function()
        require("max.picker").files({ cwd = require("max.utils.fs").root() })
      end,
      desc = "Find Files",
    },
    {
      "<leader>fc",
      function()
        require("max.picker").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config File",
    },
    {
      "<leader>ff",
      function()
        require("max.picker").files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("snacks").picker.git_files()
      end,
      desc = "Find Git Files",
    },
    {
      "<leader>fr",
      function()
        require("snacks").picker.recent()
      end,
      desc = "Recent",
    },
    -- git
    {
      "<leader>gc",
      function()
        require("snacks").picker.git_log()
      end,
      desc = "Git Log",
    },
    {
      "<leader>gs",
      function()
        require("snacks").picker.git_status()
      end,
      desc = "Git Status",
    },
    -- Grep
    {
      "<leader>sb",
      function()
        require("snacks").picker.lines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        require("snacks").picker.grep_buffers()
      end,
      desc = "Grep Open Buffers",
    },
    {
      "<leader>sg",
      function()
        require("max.picker").grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>sw",
      function()
        require("snacks").picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    -- search
    {
      '<leader>s"',
      function()
        require("snacks").picker.registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        require("snacks").picker.autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sc",
      function()
        require("snacks").picker.command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        require("snacks").picker.commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        require("snacks").picker.diagnostics()
      end,
      desc = "Diagnostics",
    },
    {
      "<leader>sh",
      function()
        require("snacks").picker.help()
      end,
      desc = "Help Pages",
    },
    {
      "<leader>sH",
      function()
        require("snacks").picker.highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>sj",
      function()
        require("snacks").picker.jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        require("snacks").picker.keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        require("snacks").picker.loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sM",
      function()
        require("snacks").picker.man()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      function()
        require("snacks").picker.marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sR",
      function()
        require("snacks").picker.resume()
      end,
      desc = "Resume",
    },
    {
      "<leader>sq",
      function()
        require("snacks").picker.qflist()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>uC",
      function()
        require("snacks").picker.colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>qp",
      function()
        require("snacks").picker.projects()
      end,
      desc = "Projects",
    },
    -- LSP
    {
      "gd",
      function()
        require("snacks").picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gr",
      function()
        require("snacks").picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        require("snacks").picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        require("snacks").picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>ss",
      function()
        require("snacks").picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
  },
}
