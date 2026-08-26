local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("vim-options")
require("lazy").setup("plugins", {
     git = {
       timeout = 600, -- seconds, default is much lower
     },
   })
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
local colors = {
  blue   = '#80a0ff',
  cyan   = '#79dac8',
  black  = '#080808',
  white  = '#c6c6c6',
  red    = '#ff5189',
  violet = '#d183e8',
  grey   = '#303030',
}

local bubble_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.white, bg = colors.grey },
    c = { fg = colors.white },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = bubbles_theme,
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
    lualine_a = {{ 'mode', fmt = function(str) return '  ' .. str end }},
    lualine_b = {{ 'filename', fmt = function(str) return ' ' .. str end }, 'branch', 'diff', 'diagnostics'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {{ 'progress', fmt = function(str) return ' ' .. str end }},
    lualine_z = {{ 'location', fmt = function(str) return ' ' .. str end }}
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
}

require("colorizer").setup({
  filetypes = { "*" }, -- filetypes to highlight, "*" for all
  buftypes = {}, -- buftypes to highlight
  user_commands = true, -- enable user commands (ColorizerToggle, etc.)
  lazy_load = false, -- lazily schedule buffer highlighting
  options = {
    parsers = {
      css = false, -- preset: enables names, hex, rgb, hsl, oklch, css_var
      css_fn = false, -- preset: enables rgb, hsl, oklch
      names = {
        enable = true, -- enable named colors (e.g. "Blue")
        lowercase = true, -- match lowercase names
        camelcase = true, -- match CamelCase names (e.g. "LightBlue")
        uppercase = false, -- match UPPERCASE names
        strip_digits = false, -- ignore names with trailing digits (e.g. "blue3")
        custom = false, -- custom name-to-hex mappings; table|function|false
        extra_word_chars = "-", -- extra chars treated as part of color name
      },
      hex = {
        default = true, -- default value for unset format keys (see above)
        rgb = true, -- #RGB (3-digit)
        rgba = true, -- #RGBA (4-digit)
        rrggbb = true, -- #RRGGBB (6-digit)
        rrggbbaa = true, -- #RRGGBBAA (8-digit)
        hash_aarrggbb = true, -- #AARRGGBB (QML-style, alpha first)
        aarrggbb = true, -- 0xAARRGGBB
        no_hash = true, -- hex without '#' at word boundaries
      },
      rgb = { enable = true }, -- rgb()/rgba() functions
      hsl = { enable = true }, -- hsl()/hsla() functions
      oklch = { enable = false }, -- oklch() function
      hwb = { enable = false }, -- hwb() function (CSS Color Level 4)
      lab = { enable = false }, -- lab() function (CIE Lab)
      lch = { enable = false }, -- lch() function (CIE LCH)
      css_color = { enable = true }, -- color() function (srgb, display-p3, a98-rgb, etc.)
      tailwind = {
        enable = false, -- parse Tailwind color names
        update_names = false, -- feed LSP colors back into name parser (requires both enable + lsp.enable)
        lsp = { -- accepts boolean, true is shortcut for { enable = true, disable_document_color = true }
          enable = false, -- use Tailwind LSP documentColor
          disable_document_color = true, -- auto-disable vim.lsp.document_color on attach
        },
      },
      sass = {
        enable = false, -- parse Sass color variables
        parsers = { css = true }, -- parsers for resolving variable values
        variable_pattern = "^%$([%w_-]+)", -- Lua pattern for variable names
      },
      xterm = { enable = false }, -- xterm 256-color codes (#xNN, \e[38;5;NNNm)
      ls_colors = { enable = false }, -- LS_COLORS/SGR snippets (e.g. =38;5;196, =48;2;0;0;255)
      xcolor = { enable = false }, -- LaTeX xcolor expressions (e.g. red!30)
      hsluv = { enable = false }, -- hsluv()/hsluvu() functions
      css_var_rgb = { enable = false }, -- CSS vars with R,G,B (e.g. --color: 240,198,198)
      css_var = {
        enable = false, -- resolve var(--name) references to their defined color
        parsers = { css = true }, -- parsers for resolving variable values
      },
      custom = {}, -- list of custom parser definitions
    },
    display = {
      mode = "virtualtext", -- string or list: "background"|"foreground"|"underline"|"virtualtext"
      background = {
        bright_fg = "#000000", -- text color on bright backgrounds
        dark_fg = "#ffffff", -- text color on dark backgrounds
      },
      virtualtext = {
        char = "", -- character used for virtualtext
        position = "before", -- "eol"|"before"|"after"
        hl_mode = "foreground", -- "background"|"foreground"
      },
      priority = {
        default = 150, -- extmark priority for normal highlights
        lsp = 200, -- extmark priority for LSP/Tailwind highlights
      },
      disable_document_color = true, -- true (all LSPs) | false | { lsp_name = true, ... }
    },
    hooks = {
      should_highlight_line = false, -- function(line, bufnr, line_num) -> bool
      should_highlight_color = false, -- function(rgb_hex, parser_name, ctx) -> bool
      transform_color = false, -- function(rgb_hex, ctx) -> string
      on_attach = false, -- function(bufnr, opts)
      on_detach = false, -- function(bufnr)
    },
    always_update = false, -- update highlights even in unfocused buffers
    debounce_ms = 0, -- debounce highlight updates (ms); 0 = no debounce
  },
})
