require("conf.variables")

local mainMod = "ALT"
local secondMod = "SUPER"

-- ============================================================================
-- Applications
-- ============================================================================

hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + SHIFT + RETURN", hl.dsp.exec_cmd(terminalTmux))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(calculator))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd(imageEditor))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd(colorPicker))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.exec_cmd(codeEditor))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd(browserBlank))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(passordManager))

-- ============================================================================
-- Window Management
-- ============================================================================

hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.window.float())
hl.bind(mainMod .. " + SHIFT + C", hl.dsp.window.center())

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

-- Move windows
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))

-- Mouse actions
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- ============================================================================
-- Resize Submap
-- ============================================================================

hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))

hl.define_submap("resize", function()
	hl.bind("L", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("H", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("J", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("K", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })

	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- ============================================================================
-- Disable Submap
-- ============================================================================

hl.bind(mainMod .. " + ESCAPE", hl.dsp.submap("disable"))

hl.define_submap("disable", function()
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- ============================================================================
-- Workspaces
-- ============================================================================

for i = 1, 10 do
	local key = i % 10

	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + SHIFT + A", hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.workspace.move({ monitor = "r" }))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.workspace.move({ monitor = "u" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.workspace.move({ monitor = "d" }))

hl.bind(mainMod .. " + Z", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + Z", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- ============================================================================
-- Media
-- ============================================================================

hl.bind(mainMod .. " + N", hl.dsp.exec_cmd(playerNext))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd(playerPrevious))
hl.bind(mainMod .. " + SPACE", hl.dsp.exec_cmd(playerPlayPause))

-- ============================================================================
-- Session
-- ============================================================================

hl.bind(mainMod .. " + SHIFT + ESCAPE", hl.dsp.exec_cmd(shutdownMenu))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(reloadHyprland))

hl.bind(secondMod .. " + L", hl.dsp.exec_cmd(lockScreen))
hl.bind(secondMod .. " + X", hl.dsp.exec_cmd(logoutMenu))

-- ============================================================================
-- Screenshots / Clipboard
-- ============================================================================

hl.bind(secondMod .. " + V", hl.dsp.exec_cmd(clipboardManager))
hl.bind(secondMod .. " + S", hl.dsp.exec_cmd(screenshotFull))
hl.bind(secondMod .. " + SHIFT + S", hl.dsp.exec_cmd(screenshotRegion))

-- ============================================================================
-- Appearance
-- ============================================================================

hl.bind(secondMod .. " + SHIFT + W", hl.dsp.exec_cmd(wallpaperPicker))
hl.bind(secondMod .. " + SHIFT + N", hl.dsp.exec_cmd(nightLightToggle))

-- ============================================================================
-- Multimedia Keys
-- ============================================================================

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(volumeUp), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(volumeDown), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(volumeMute), { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(micMute), { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(brightnessUp), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightnessDown), { locked = true, repeating = true })

hl.bind("XF86AudioNext", hl.dsp.exec_cmd(osdPlayerNext), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd(osdPlayerPlayPause), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(osdPlayerPlay), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(osdPlayerPrevious), { locked = true })

hl.bind("XF86PowerOff", hl.dsp.exec_cmd(suspendCmd), { locked = true })
