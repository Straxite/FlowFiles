local get_username = function()
  return vim.env.USER or vim.env.USERNAME or "unknown"
end

require("colors")
local colors1 = require("colors")

local cheeze = {
  normal = {
    a = { fg = colors1.surface, bg = colors1.primary },
    b = { fg = colors1.tertiary, bg = colors1.surface_container_highest },
    c = { fg = colors1.white },
    x = { fg = colors1.tertiary, bg = colors1.tertiary},
    y = { fg = colors1.primary, bg = colors1.surface_container_highest },
    z = { fg = colors1.primary, bg = colors1.surface_container_highest }
  },

  insert = {
    a = { fg = colors1.surface, bg = colors1.tertiary },
    b = { fg = colors1.tertiary, bg = colors1.surface_container_highest },
    c = { fg = colors1.white },
    y = { fg = colors1.primary, bg = colors1.surface_container_highest },
    z = { fg = colors1.primary, bg = colors1.surface_container_highest }
  },
  visual = {
    a = { fg = colors1.surface, bg = colors1.secondary },
    b = { fg = colors1.tertiary, bg = colors1.surface_container_highest },
    c = { fg = colors1.white },
    y = { fg = colors1.primary, bg = colors1.surface_container_highest },
    z = { fg = colors1.primary, bg = colors1.surface_container_highest }
  },
  replace = {
    a = { fg = colors1.surface, bg = colors1.on_primary },
    b = { fg = colors1.tertiary, bg = colors1.surface_container_highest },
    c = { fg = colors1.white },
    y = { fg = colors1.primary, bg = colors1.surface_container_highest },
    z = { fg = colors1.primary, bg = colors1.surface_container_highest }
  },

  inactive = {
    a = { fg = colors1.white, bg = colors1.black },
    b = { fg = colors1.white, bg = colors1.black },
    c = { fg = colors1.white },
    y = { fg = colors1.primary, bg = colors1.on_tertiary_fixed },
    z = { fg = colors1.primary, bg = colors1.surface_container_highest }
  },
}

require('lualine').setup({
  options = {
    icons_enabled = true,
    theme = cheeze,
    component_separators = { left = '', right = '│'},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
      refresh_time = 16, -- ~60fps
      events = {
        'WinEnter',
        'BufEnter',
        'BufWritePost',
        'SessionLoadPost',
        'FileChangedShellPost',
        'VimResized',
        'CursorMoved',
        'CursorMovedI',
        'ModeChanged',
      },
    }
  },
  sections = {
    lualine_a = {{ 'mode', icon = '' }},
    lualine_b = {{function() return ' ' end, color = { bg = colors1.surface_container }, padding = { left= 0, right = 0 }, separator = { right = '' }}, {'filetype', icon_only = true, separator = "", padding = { left = 1, right = 0 }},{ 'filename', padding = { left = 0, right = 1 } }, 'branch', 'diff', 'diagnostics'},
    lualine_c = {},
    lualine_x = { { function() return "󰉋 " end, separator = { left = '', right = '' }, color = { fg = colors1.surface_container_highest, bg = colors1.tertiary }, padding = { left = 0, right = 0 } }, {
        get_username,
        separator = { left = '', right = '' },
        color = { bg = colors1.surface_container_highest, fg = colors1.tertiary, gui = 'bold' },
        padding = { left = 1, right = 1 }, -- Prevents padding from breaking the outside of the bubble container
      } },
    lualine_y = {},
    lualine_z = {{ function() local line = vim.fn.line('.') local col = vim.fn.virtcol('.') return string.format('%d/%d', line, col) end, icon = { ' ', color = {fg = colors1.surface_container, bg = colors1.primary} } , padding = { left = 0, right = 1 }}}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
})
