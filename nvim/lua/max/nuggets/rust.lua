local ts = vim.treesitter

local M = {}

---@param node TSNode | nil
---@return string | nil
local function construct_test_name(node)
  if node == nil then
    return
  end

  if node:type() ~= "function_item" then
    return construct_test_name(node:parent())
  end

  local identifier_node = node:field("name")[1]

  if identifier_node == nil then
    return construct_test_name(node:parent())
  end

  return ts.get_node_text(identifier_node, 0)
end

local function run_test_under_cursor()
  local root = require("max.utils.fs").root()
  local root_node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  local name = construct_test_name(root_node)

  if name == nil then
    vim.notify("No test found", vim.log.levels.ERROR)
    return
  end

  local cmd = string.format("cargo test %s -- --nocapture", name)
  vim.print(cmd)
  require("max.utils.terminal").open({
    cmd = cmd,
    cwd = root,
  })
end

local function run_current_buffer()
  vim.notify("Not yet implemented", vim.log.levels.ERROR)
  -- local root = require("max.utils.fs").root()
  -- local filepath = trim_path_after_last_paren(vim.api.nvim_buf_get_name(0))
  -- local cmd = string.format("npx jest -i %s", filepath)
  -- vim.print(cmd)
  -- require("max.utils.terminal").open({
  --   cmd = cmd,
  --   cwd = root,
  -- })
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.rs" },
  callback = function()
    vim.keymap.set("n", "<leader>tt", run_test_under_cursor, { desc = "Run test test on cursor" })
    vim.keymap.set("n", "<leader>tf", run_current_buffer, { desc = "Run test on current buffer" })
  end,
})

return M
