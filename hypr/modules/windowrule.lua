--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})


hl.window_rule({
  name      = "move-kitty",
  match     = { class = "kitty" },
  move      = {100, 100},
  animation = "slide"
})

hl.layer_rule({
  match     = { namespace = "waybar" },
  animation = "slidefade",
})

hl.layer_rule({
  match     = { namespace = "swaync-control-center" },
  animation = "slide right",
  dim_around    = true,
  blur          = true,
  ignore_alpha  = 0.5,
})

hl.layer_rule({
  match     = { namespace = "swaync-notification-window" },
  animation = "slide right",
  blur      = true,
  ignore_alpha  = 0.5,
})


hl.layer_rule({
  match     = { namespace = "logout_dialog" },
  blur      = true,
})

hl.window_rule({
  name      = "float4",
  match     = { class = "com.gabm.satty" },
  float     = true,
  size      = {1200, 800},
})

hl.window_rule({
  name      = "float3",
  match     = { class = "impala-nm" },
  float     = true,
  size      = {1200, 800},
})

hl.window_rule({
  name      = "float2",
  match     = { class = "nwg-look" },
  float     = true,
  size      = {1200, 800},
})

hl.window_rule({
  name      = "float1",
  match     = { class = "bluetuith" },
  float     = true,
  size      = {1200, 800},
})

hl.window_rule({
  name      = "float",
  match     = { class = "org.pulseaudio.pavucontrol" },
  float     = true,
  size      = {1200, 800},
})

hl.layer_rule({
  match     = { namespace = "rofi" },
  dim_around      = true,
})
