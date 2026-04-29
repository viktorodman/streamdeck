-- Connect iPad as extended display via Control Centre → Screen Mirroring → Sidecar device.
-- Bind in Stream Deck (System → Open) or run: osascript connect-ipad.applescript

tell application "System Events"
	tell process "ControlCenter"
		click (first menu bar item of menu bar 1 whose description is "Control Centre")
		delay 1.0

		-- Click Screen Mirroring tile
		set smTile to missing value
		repeat with c in (checkboxes of group 1 of window 1)
			try
				if (value of attribute "AXIdentifier" of c) is "controlcenter-screen-mirroring" then
					set smTile to contents of c
					exit repeat
				end if
			end try
		end repeat
		if smTile is missing value then error "Screen Mirroring tile not found"
		click smTile
		delay 1.0

		-- Click the Sidecar device (the iPad)
		set deviceList to missing value
		repeat with g in (groups of scroll area 1 of group 1 of window 1)
			try
				if (value of attribute "AXIdentifier" of g) is "screen-mirroring-device-list" then
					set deviceList to contents of g
					exit repeat
				end if
			end try
		end repeat
		if deviceList is missing value then error "device list not found"

		set ipad to missing value
		repeat with c in (checkboxes of deviceList)
			try
				set axId to (value of attribute "AXIdentifier" of c) as text
				if axId starts with "screen-mirroring-device-Sidecar:" then
					set ipad to contents of c
					exit repeat
				end if
			end try
		end repeat
		if ipad is missing value then error "Sidecar device not found in mirroring list"
		click ipad
	end tell
end tell
