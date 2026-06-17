-- ============================================================================
-- Applications
-- ============================================================================

terminal = "kitty"
terminalTmux = terminal .. " -e tmux"

fileManager = "thunar"
imageEditor = "gimp -n"
codeEditor = "code"
notes = "obsidian"

-- ============================================================================
-- Launchers
-- ============================================================================

menu = "pkill rofi || rofi -show drun"
calculator = "pkill rofi || rofi -show calc"

-- ============================================================================
-- Utilities
-- ============================================================================

colorPicker = "hyprpicker -a"
clipboardManager = "cliphist-ui"

-- ============================================================================
-- Browser
-- ============================================================================

browserBlank = "xdg-open http://about:blank"

-- ============================================================================
-- Appearance
-- ============================================================================

wallpaperPicker = "~/.config/scripts/wallpaper-picker"
nightLightToggle =
	"pkill hyprsunset || hyprsunset --gamma 60% --temperature 3000"

-- ============================================================================
-- Session
-- ============================================================================

lockScreen = "hyprlock -q"
logoutMenu = "wleave"
suspendCmd = "systemctl suspend"
reloadHyprland = "hyprctl reload"

shutdownMenu =
	"command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit"

-- ============================================================================
-- Media
-- ============================================================================

playerNext = "playerctl next"
playerPrevious = "playerctl previous"
playerPlayPause = "playerctl play-pause"

-- ============================================================================
-- OSD Media
-- ============================================================================

osdPlayerNext = "swayosd-client --playerctl next"
osdPlayerPrevious = "swayosd-client --playerctl previous"
osdPlayerPlay = "swayosd-client --playerctl play"
osdPlayerPlayPause = "swayosd-client --playerctl play-pause"

-- ============================================================================
-- Volume
-- ============================================================================

volumeUp = "swayosd-client --output-volume +5"
volumeDown = "swayosd-client --output-volume -5"
volumeMute = "swayosd-client --output-volume mute-toggle"
micMute = "~/.config/scripts/micmute"

-- ============================================================================
-- Brightness
-- ============================================================================

brightnessUp = "swayosd-client --brightness +5"
brightnessDown = "swayosd-client --brightness -5"

-- ============================================================================
-- Screenshots
-- ============================================================================

screenshotFull = "grim - | swappy -f -"
screenshotRegion = 'grim -g "$(slurp)" - | swappy -f -'

-- ============================================================================
-- Autostart
-- ============================================================================

keyringDaemon = "gnome-keyring-daemon --start --components=secrets"

graphicalSessionTarget = "systemctl --user start hyprland-session.target"

dbusUpdateEnv = "dbus-update-activation-environment --systemd --all"
dbusUpdateSystemdEnv =
	"sleep 1 && dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

idleDaemon = "hypridle"

waybarWatch = "~/.config/scripts/waybar-watch"
notificationDaemon = "swaync"
osdServer = "swayosd-server -s ~/.config/swayosd/style.css"

wallpaperDaemon = "hyprpaper"

networkApplet = "nm-applet"
bluetoothApplet = "blueman-applet"
diskApplet = "udiskie --appindicator"
onePassword = "1password --silent"

logoutMenuService = "wleave --service"

clipboardImageWatcher = "wl-paste --type image --watch cliphist store"
clipboardTextWatcher = "wl-paste --type text --watch cliphist store"
clipboardService = "cliphist-ui --service"

-- ============================================================================
-- Startup Workspaces
-- ============================================================================

startupWorkspaces = {
    "[workspace 1] eDP-1",
	"[workspace 2] HDMI-A-1",
	"[workspace 3] DP-1",
}

-- ============================================================================
-- Startup Applications
-- ============================================================================

startupApps = {
	"slack",
}
