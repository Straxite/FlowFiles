require("colors")
local colors1 = require("colors")

vim.api.nvim_set_hl(0, "icons", { fg = colors1.tertiary }) -- Replace with your preferred hex code

require('nvim-web-devicons').setup({
    color_icons = false,
    default = true, -- Ensures a default fallback icon is used
})

local devicons = require('nvim-web-devicons')
local icons = devicons.get_icons()

for _, icon_data in pairs(icons) do
    icon_data.color = colors1.tertiary          -- For plugins that read the raw hex string
    icon_data.name = "icons" -- For plugins that look for the highlight group name
end
