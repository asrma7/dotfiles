-- ============================================================================
-- Window Rules
-- ============================================================================

hl.window_rule({
	name = "suppress-maximize-events",
	match = {
		class = ".*",
	},
	suppress_event = "maximize",
})

hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- ============================================================================
-- Application Rules
-- ============================================================================
hl.window_rule({
    name = "slack-workspace",
    match = {
        class = "^(slack)$",
    },
    workspace = "4 silent",
})

hl.window_rule({
    name = "thunar-rename-float",
    match = {
        class = "^(thunar)$",
        title = "^(Rename .*)$",
    },
    float = true,
})

-- ============================================================================
-- Media / Floating Rules
-- ============================================================================

hl.window_rule({
	name = "vlc-float",
	match = {
		class = "^(vlc)$",
	},
	float = true,
})

hl.window_rule({
	name = "vlc-opacity",
	match = {
		class = "^(vlc)$",
	},
	opacity = "1 0.9",
})

hl.window_rule({
	name = "mpv-float",
	match = {
		class = "^(mpv)$",
	},
	float = true,
})

hl.window_rule({
	name = "mpv-opacity",
	match = {
		class = "^(mpv)$",
	},
	opacity = "1 0.9",
})

hl.window_rule({
	name = "imv-float",
	match = {
		class = "^(imv)$",
	},
	float = true,
})

hl.window_rule({
	name = "imv-center",
	match = {
		class = "^(imv)$",
	},
	center = true,
})

hl.window_rule({
	name = "imv-size",
	match = {
		class = "^(imv)$",
	},
	size = { "75%", "75%" },
})

hl.window_rule({
	name = "picture-in-picture-float",
	match = {
		title = "^(Picture-in-Picture)$",
	},
	float = true,
})

hl.window_rule({
	name = "file-picker-float",
	match = {
		class = ".*",
		title = "^(Open File.*)$",
	},
	float = true,
})

-- ============================================================================
-- Torrent / Utility Rules
-- ============================================================================

hl.window_rule({
	name = "qbittorrent-float",
	match = {
		class = "^(org.qbittorrent.qBittorrent)$",
	},
	float = true,
})

hl.window_rule({
	name = "qbittorrent-main-tile",
	match = {
		class = "^(org.qbittorrent.qBittorrent)$",
		title = "^(qBittorrent.*)$",
	},
	tile = true,
})

-- ============================================================================
-- Layer Rules
-- ============================================================================

hl.layer_rule({
	match = {
		namespace = "rofi",
	},
	blur = true,
	ignore_alpha = 0,
	dim_around = true,
})

hl.layer_rule({
	match = {
		namespace = "waybar",
	},
	ignore_alpha = 0,
})

hl.layer_rule({
	match = {
		namespace = "swaync-control-center",
	},
	blur = true,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	match = {
		namespace = "swaync-notification-window",
	},
	blur = true,
	ignore_alpha = 0.3,
})

hl.layer_rule({
	match = {
		namespace = "swayosd",
	},
	blur = true,
	ignore_alpha = 0.5,
})

hl.layer_rule({
	match = {
		namespace = "wleave",
	},
	blur = true,
})

hl.layer_rule({
	match = {
		namespace = "gtk4-layer-shell",
	},
	no_anim = true,
})
