---@param name string
local function open_task_if_exists(name)
  local overseer = require("overseer")

  ---@param task overseer.Task
  local function init_float(task)
    overseer.run_action(task, "open float")
    vim.cmd("startinsert!")
    vim.keymap.set("t", "<esc><esc>", function()
      vim.cmd.close()
    end)
  end

  ---@type overseer.Task|nil
  local task = overseer.list_tasks({ name = name })[1]

  if not task then
    return overseer.run_template({ name = name }, init_float)
  end

  if not task:is_running() then
    return overseer.run_template({ name = name }, init_float)
  end

  init_float(task)
end

local function lazygit()
  local overseer = require("overseer")
  local name = "lazygit"
  local desc = "Launches lazygit"
  vim.keymap.set("n", "<leader>gg", function()
    open_task_if_exists(name)
  end, { desc = desc })

  ---@type overseer.TemplateDefinition
  local template = {
    name = name,
    builder = function()
      ---@type overseer.TaskDefinition
      return {
        cmd = name,
        cwd = vim.fn.getcwd(),
        components = {
          "unique",
          "lazygit.close_on_exit",
        },
      }
    end,
    desc = desc,
  }

  overseer.register_template(template)
end

local function codex()
  local overseer = require("overseer")
  local name = "codex"
  local desc = "Launches codex"
  vim.keymap.set("n", "<leader>cc", function()
    open_task_if_exists(name)
  end, { desc = desc })

  local api_key = require("max.utils.fs").read_file("~/.secrets/openai-api-key")
  if not api_key then
    return
  end

  ---@type overseer.TemplateDefinition
  local template = {
    name = name,
    builder = function()
      ---@type overseer.TaskDefinition
      return {
        cmd = name,
        cwd = vim.fn.getcwd(),
        env = {
          OPENAI_API_KEY = api_key,
        },
        components = {
          "unique",
          "lazygit.close_on_exit",
        },
      }
    end,
    desc = desc,
  }
  overseer.register_template(template)
end

---@module "lazy"
---@type LazySpec
return {
  "stevearc/overseer.nvim",
  event = "VeryLazy",
  config = function()
    local overseer = require("overseer")
    overseer.setup({ task_win = { border = "none", padding = 3 } })

    lazygit()
    codex()
  end,
}
