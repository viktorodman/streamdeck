-- Lists every menu bar item exposed by the ControlCenter process,
-- so we can see what the Control Center icon is actually called.

tell application "System Events"
	tell process "ControlCenter"
		set itemDescriptions to {}
		repeat with mbi in menu bar items of menu bar 1
			set end of itemDescriptions to (name of mbi as text) & " | desc=" & (description of mbi as text)
		end repeat
		return itemDescriptions
	end tell
end tell
