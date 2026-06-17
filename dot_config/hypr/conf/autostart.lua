require("conf.variables")

hl.on("hyprland.start", function()
	-- Session / portals
	hl.exec_cmd(keyringDaemon)
    hl.exec_cmd(dbusUpdateEnv)
    hl.exec_cmd(graphicalSessionTarget)
	hl.exec_cmd(dbusUpdateEnv)
	hl.exec_cmd(dbusUpdateSystemdEnv)

	-- Idle / lock helpers
	hl.exec_cmd(idleDaemon)

	-- Panels / notifications / OSD
	hl.exec_cmd(waybarWatch)
	hl.exec_cmd(notificationDaemon)
	hl.exec_cmd(osdServer)

	-- Wallpaper
	hl.exec_cmd(wallpaperDaemon)

	-- Applets / trays
	hl.exec_cmd(networkApplet)
	hl.exec_cmd(bluetoothApplet)
	hl.exec_cmd(diskApplet)
    hl.exec_cmd(onePassword)

	-- Session menu service
	hl.exec_cmd(logoutMenuService)

	-- Clipboard
	hl.exec_cmd(clipboardImageWatcher)
	hl.exec_cmd(clipboardTextWatcher)
	hl.exec_cmd(clipboardService)

    -- Initial workspaces
	for _, workspace in ipairs(startupWorkspaces) do
		hl.exec_cmd(workspace)
	end

    -- Startup applications
    for _, app in ipairs(startupApps) do
        hl.exec_cmd(app)
    end
end)
