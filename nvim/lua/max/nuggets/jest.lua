local ts = vim.treesitter

local M = {}

local test_fns = {
  "it",
  "describe",
  "test",
}

---@param node TSNode | nil
---@return TSNode | nil
local function find_test_fn(node)
  if node == nil then
    return
  end

  if node:type() ~= "call_expression" then
    return find_test_fn(node:parent())
  end

  local identifier_node = node:field("function")[1]

  if identifier_node == nil then
    return find_test_fn(node:parent())
  end

  local function_name = ts.get_node_text(identifier_node, 0)
  if vim.tbl_contains(test_fns, function_name) then
    return node
  end

  return find_test_fn(node:parent())
end

---@return string|nil
local function test_name()
  local root_node = require("nvim-treesitter.ts_utils").get_node_at_cursor()
  -- Traverse upwards until a function with name "it", "describe" or "test is found"
  local node = find_test_fn(root_node)

  if node == nil then
    return
  end

  -- Get first argument of the test function
  local args = node:field("arguments")[1]
  if args and args:named_child_count() > 0 then
    local first_arg_node = args:named_child(0)
    if first_arg_node == nil then
      return
    end
    return ts.get_node_text(first_arg_node, 0)
  end
end

--- @param filepath string
local function trim_path_after_last_paren(filepath)
  -- Find the last occurrence of ')'
  local last_paren_index = filepath:match(".*()%)")

  if last_paren_index then
    return filepath:sub(last_paren_index + 1)
  else
    return filepath
  end
end

function M.run_test_under_cursor()
  local root = require("max.utils.fs").root()
  local filepath = trim_path_after_last_paren(vim.api.nvim_buf_get_name(0))
  local name = test_name()

  if name == nil then
    return
  end
  local cmd = string.format("npx jest -i %s -t %s", filepath, name)
  vim.print(cmd)
  require("max.utils.terminal").open({
    cmd = cmd,
    cwd = root,
  })
end

function M.run_current_buffer()
  local root = require("max.utils.fs").root()
  local filepath = trim_path_after_last_paren(vim.api.nvim_buf_get_name(0))
  local cmd = string.format("npx jest -i %s", filepath)
  vim.print(cmd)
  require("max.utils.terminal").open({
    cmd = cmd,
    cwd = root,
  })
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*test.ts", "*test.tsx" },
  callback = function()
    vim.keymap.set("n", "<leader>tt", M.run_test_under_cursor, { desc = "Run jest test on cursor" })
    vim.keymap.set("n", "<leader>tf", M.run_current_buffer, { desc = "Run jest test on current buffer" })
  end,
})

return M
