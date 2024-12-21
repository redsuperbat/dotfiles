local M = {}

---@type table<string, integer>
local terminals = {}

---@class FloatingTerminalOptions
---@field on_buf_create? fun(buf: integer): nil
---@field border? string
---@param cmd? string[]|string
---@param opts? FloatingTerminalOptions
function M.open(cmd, opts)
  cmd = cmd or vim.o.shell
  local terminal_key = vim.inspect({ cmd = cmd, count = vim.v.count1 })
  local terminal = terminals[terminal_key]
  local border = (opts and opts.border) or "rounded"

  local function win_config()
    local editor_width = vim.o.columns
    local editor_height = vim.o.lines
    local width = math.floor(editor_width * 0.8)
    local height = math.floor(editor_height * 0.8)
    local col = math.floor((editor_width - width) / 2)
    local row = math.floor((editor_height - height) / 2)

    return {
      relative = "editor",
      style = "minimal",
      border = border,
      width = width,
      height = height,
      col = col,
      row = row,
    }
  end

  ---@param buf integer
  local open_win = function(buf)
    vim.api.nvim_create_autocmd("BufEnter", {
      buffer = buf,
      callback = function()
        vim.cmd.startinsert()
      end,
    })
    local win = vim.api.nvim_open_win(buf, true, win_config())
    vim.api.nvim_set_hl(0, "FloatBorder", { bg = "#1f1f28" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1f1f28" })
    return win
  end

  ---@param buf integer
  local function open_win_with_resize(buf)
    local win = open_win(buf)
    vim.api.nvim_create_autocmd("VimResized", {
      callback = function()
        if not vim.api.nvim_win_is_valid(win) then
          return
        end
        vim.api.nvim_win_set_config(win, win_config())
      end,
    })
  end

  if vim.api.nvim_buf_is_valid(terminal or -1) then
    return open_win_with_resize(terminal)
  end

  local buf = vim.api.nvim_create_buf(false, true)
  open_win_with_resize(buf)

  vim.fn.termopen(cmd)

  vim.keymap.set("t", "<esc><esc>", "<c-\\><c-n>", { buffer = buf, nowait = true })
  vim.keymap.set("n", "q", "<cmd>q<CR>", { buffer = buf, nowait = true })

  if opts and opts.on_buf_create then
    opts.on_buf_create(buf)
  end

  vim.keymap.set({ "t", "n" }, "<c-h>", "<c-h>", { buffer = buf, nowait = true })
  vim.keymap.set({ "t", "n" }, "<c-j>", "<c-j>", { buffer = buf, nowait = true })
  vim.keymap.set({ "t", "n" }, "<c-k>", "<c-k>", { buffer = buf, nowait = true })
  vim.keymap.set({ "t", "n" }, "<c-l>", "<c-l>", { buffer = buf, nowait = true })

  vim.cmd("noh")
  terminals[terminal_key] = buf
end

return M
