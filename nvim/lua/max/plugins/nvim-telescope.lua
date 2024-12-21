---@class LiveMultiGrepOpts
---@field cwd string
---@param opts LiveMultiGrepOpts
local function live_multi_grep(opts)
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local make_entry = require("telescope.make_entry")
  local conf = require("telescope.config")

  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job({
    command_generator = function(prompt)
      if not prompt or prompt == "" then
        return nil
      end
      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      -- Glob search on files which is preceding double space
      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, pieces[2])
      end
      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten({
        args,
        {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      })
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  })

  pickers
    .new(opts, {
      finder = finder,
      debounce = 100,
      prompt_title = "Multi Grep",
      previewer = conf.values.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  version = false, -- telescope did only one release, so use HEAD for now
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
  },
  keys = {
    { "<leader>:", "<cmd>Telescope command_history<cr>", desc = "Command History" },

    -- find
    {
      "<leader><space>",
      function()
        require("telescope.builtin").find_files({
          cwd = require("max.utils.fs").root(),
          hidden = true,
        })
      end,
      desc = "Find Files (Root Dir)",
    },
    { "<leader>fb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files (Root Dir)" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Files (git-files)" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "Commits" },
    { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "Status" },
    -- search
    { '<leader>s"', "<cmd>Telescope registers<cr>", desc = "Registers" },
    { "<leader>sa", "<cmd>Telescope autocommands<cr>", desc = "Auto Commands" },
    { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>sc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>sC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document Diagnostics" },
    { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace Diagnostics" },
    { "<leader>sg", live_multi_grep, desc = "Grep (CWD Dir)" },
    {
      "<leader>sG",
      function()
        live_multi_grep({
          cwd = require("max.utils.fs").root(),
        })
      end,
      desc = "Grep (Root Dir)",
    },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>sH", "<cmd>Telescope highlights<cr>", desc = "Search Highlight Groups" },
    { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>sM", "<cmd>Telescope man_pages<cr>", desc = "Man Pages" },
    { "<leader>sm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    { "<leader>so", "<cmd>Telescope vim_options<cr>", desc = "Options" },
    { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
    {
      "<leader>sS",
      function()
        require("telescope.builtin").lsp_dynamic_workspace_symbols({
          cwd = require("max.utils.fs").root(),
        })
      end,
      desc = "Goto Symbol (Workspace)",
    },
  },
  config = function()
    local actions = require("telescope.actions")

    require("telescope").setup({
      extensions = { "fzf" },
      defaults = {
        preview = {
          treesitter = true,
        },
        prompt_prefix = " ",
        selection_caret = " ",
        hidden = true,
        file_ignore_patterns = {
          ".git/",
        },
        -- open files in the first window that is an actual file.
        -- use the current window if no other window is available.
        get_selection_window = function()
          local wins = vim.api.nvim_list_wins()
          table.insert(wins, 1, vim.api.nvim_get_current_win())
          for _, win in ipairs(wins) do
            local buf = vim.api.nvim_win_get_buf(win)
            if vim.bo[buf].buftype == "" then
              return win
            end
          end
          return 0
        end,
        mappings = {
          i = {
            ["<C-f>"] = actions.preview_scrolling_down,
            ["<C-b>"] = actions.preview_scrolling_up,
            -- Disable up and down when telescope is open to force me to use proper keybinds
            ["<Up>"] = function() end,
            ["<Down>"] = function() end,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
    })
  end,
}
