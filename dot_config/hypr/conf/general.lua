local colors = require("matugen.matugen-hyprland")

-- MONITOR CONFIG
hl.monitor({
	output = "eDP-1",
	mode = "preferred@144Hz",
	position = "0x0",
	scale = 1,
})

hl.monitor({
	output = "DP-1",
	mode = "2560x1440@165Hz",
	position = "1920x0",
	scale = 1,
})

hl.monitor({
	output = "HDMI-A-1",
	mode = "1920x1080@144Hz",
	position = "4480x0",
	scale = 1,
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.config({
	general = {
		gaps_in = 4,
		gaps_out = 12,

		border_size = 2,

		col = {
			active_border = { colors = { colors.primary, colors.primary_container, colors.tertiary, colors.primary }, angle = 45 },
			inactive_border = colors.alpha(colors.outline_variant, "33"),
		},
		resize_on_border = true,

		no_focus_fallback = true,
		allow_tearing = true,
	},
	decoration = {
		rounding_power = 0,
		rounding = 0,

		active_opacity = 1.0,
		inactive_opacity = 0.9,
		blur = {
			enabled = true,
			xray = true,
			size = 10,
			passes = 3,
			vibrancy = 0.1696,
			popups = false,
			popups_ignorealpha = 0.6,
			input_methods = true,
			input_methods_ignorealpha = 0.8,
		},
		shadow = {
			enabled = true,
			range = 10,
			offset = { 0, 2 },
			render_power = 5,
			color = colors.alpha(colors.primary, "66"),
			color_inactive = colors.alpha(colors.shadow, "66"),
		},
		-- Dim
		dim_inactive = true,
		dim_strength = 0.1,
		dim_special = 0.2,
	},
	animations = {
		enabled = true,
	},
	dwindle = {
		preserve_split = true,
		smart_split = false,
		smart_resizing = false,
	},
})

hl.config({
	input = {
		kb_layout = "us",
		repeat_delay = 250,
		repeat_rate = 35,

		follow_mouse = 1,
		off_window_axis_events = 2,

		touchpad = {
			natural_scroll = true,
			disable_while_typing = true,
			clickfinger_behavior = true,
			scroll_factor = 0.7,
		},
	},

	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		vrr = 3,
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		enable_swallow = true,
		swallow_regex = "(ghostty|kitty)",
		on_focus_under_fullscreen = 2,
		allow_session_lock_restore = true,
		initial_workspace_tracking = false,
		focus_on_activate = true,
	},

	binds = {
		scroll_event_delay = 0,
		hide_special_on_workspace_change = true,
	},

	cursor = {
		zoom_factor = 1,
		zoom_rigid = false,
		zoom_disable_aa = true,
		hotspot_padding = 1,
	},

	xwayland = {
		force_zero_scaling = true,
	},
})
