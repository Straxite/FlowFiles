-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
local C = require("colors")
hl.config({
    general = {
        gaps_in  = 5,
        gaps_out = 20,

        border_size = 2,

        col = {
            active_border   = { colors = {C.surface_container_lowest, C.surface_container_lowest}, angle = 45 },
            inactive_border = C.surface_dim,
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "dwindle",
    },

    decoration = {
        rounding       = 20,
        rounding_power = 2,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled      = true,
            range        = 15,
            render_power = 1,
            color        = C.scrim,
        },

        blur = {
            enabled   = true,
            size      = 10,
            passes    = 2,
            vibrancy  = 1,
        },
    },

    animations = {
        enabled = true,
    },
})
