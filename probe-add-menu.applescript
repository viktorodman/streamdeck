-- Click the Add menu button and dump menu items.

do shell script "open 'x-apple.systempreferences:com.apple.Displays-Settings.extension'"
delay 2.5

tell application "System Events"
	tell process "System Settings"
		set frontmost to true
		delay 0.5

		set addBtn to missing value
		repeat with e in (entire contents of window 1)
			try
				if (class of e) is menu button then
					if (value of attribute "AXIdentifier" of e) is "plus" then
						set addBtn to contents of e
						exit repeat
					end if
				end if
			end try
		end repeat

		if addBtn is missing value then
			return "ERR: not found"
		end if

		click addBtn
		delay 0.6

		set output to {}
		try
			set menuItems to menu items of menu 1 of addBtn
			set end of output to "items=" & (count of menuItems)
			repeat with i from 1 to count of menuItems
				set mi to item i of menuItems
				set miName to ""
				set miEnabled to ""
				try
					set miName to (name of mi) as text
				end try
				try
					set miEnabled to (enabled of mi) as text
				end try
				set end of output to (i as text) & " | name=" & miName & " | enabled=" & miEnabled
			end repeat
		on error errMsg
			set end of output to "ERR: " & errMsg
		end try

		key code 53
		return output
	end tell
end tell
