return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    local logo = [[










     .-') _   ('-.                     (`-.           _   .-')    
    ( OO ) )_(  OO)                  _(OO  )_        ( '.( OO )_  
,--./ ,--,'(,------. .-'),-----. ,--(_/   ,. \ ,-.-') ,--.   ,--.)
|   \ |  |\ |  .---'( OO'  .-.  '\   \   /(__/ |  |OO)|   `.'   | 
|    \|  | )|  |    /   |  | |  | \   \ /   /  |  |  \|         | 
|  .     |/(|  '--. \_) |  |\|  |  \   '   /,  |  |(_/|  |'.'|  | 
|  |\    |  |  .--'   \ |  | |  |   \     /__),|  |_.'|  |   |  | 
|  | \   |  |  `---.   `'  '-'  '    \   /   (_|  |   |  |   |  | 
`--'  `--'  `------'     `-----'      `-'      `--'   `--'   `--' 

]]

    local opts = {
      theme = "doom",
      config = {
        header = vim.split(logo, "\n"),
        center = {
          {
            action = function()
              require("max.picker").files()
            end,
            desc = " Find File",
            icon = "🔍",
            key = "f",
          },
          {
            action = function()
              require("snacks").picker.recent()
            end,
            desc = " Recent Files",
            icon = "📁",
            key = "r",
          },
          {
            action = function()
              require("max.picker").grep()
            end,
            desc = " Find Text",
            icon = "📗",
            key = "g",
          },
          {
            action = function()
              require("max.picker").files({ cwd = vim.fn.stdpath("config") })
            end,
            desc = " Config",
            icon = "🤖",
            key = "c",
          },
          {
            action = "qa",
            desc = " Quit",
            icon = "💨",
            key = "q",
          },
        },
        footer = function()
          local stats = require("lazy").stats()
          local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
          local no_plugins = stats.loaded
          local total_plugins = stats.count
          return {
            "🚀 Great config dude, lazy loaded "
              .. no_plugins
              .. "/"
              .. total_plugins
              .. " plugins in "
              .. ms
              .. "ms",
          }
        end,
      },
    }

    for _, button in ipairs(opts.config.center) do
      button.desc = button.desc .. string.rep(" ", 43 - #button.desc)
      button.key_format = "  %s"
    end

    -- close Lazy and re-open when the dashboard is ready
    if vim.o.filetype == "lazy" then
      vim.cmd.close()
      vim.api.nvim_create_autocmd("User", {
        pattern = "DashboardLoaded",
        callback = function()
          require("lazy").show()
        end,
      })
    end
    vim.api.nvim_set_hl(0, "DashboardHeader", {
      fg = "#F08080",
    })

    require("dashboard").setup(opts)
  end,
}
