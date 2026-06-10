local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

hl.layer_rule({
    match = { namespace = "swaync-control-center" },
    blur = true,
    ignore_alpha = 0.3,
})

hl.layer_rule({
    match = { namespace = "swaync-notification-window" },
    blur = true,
    ignore_alpha = 0.3,
})

hl.layer_rule({
    match = { namespace = "swayosd" },
    blur = true,
    ignore_alpha = 0.5,
})

hl.layer_rule({
    match = { namespace = "wleave" },
    blur = true,
})



hl.layer_rule({ match = { namespace = "gtk4-layer-shell" }, no_anim = true })

