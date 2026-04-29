set diag to {}

tell application "System Events"
	tell process "ControlCenter"
		click (first menu bar item of menu bar 1 whose description is "Control Centre")
		delay 1.0

		set smTile to missing value
		repeat with c in (checkboxes of group 1 of window 1)
			try
				if (value of attribute "AXIdentifier" of c) is "controlcenter-screen-mirroring" then
					set smTile to contents of c
					exit repeat
				end if
			end try
		end repeat
		click smTile
		delay 1.0

		-- Walk the scroll area to find devices
		set sa to scroll area 1 of group 1 of window 1
		set end of diag to "scroll area UI element count=" & (count of UI elements of sa)

		repeat with depth1 in (UI elements of sa)
			set d1Class to (class of depth1 as text)
			set d1Name to ""
			set d1Id to ""
			try
				set d1Name to (name of depth1) as text
			end try
			try
				set d1Id to (value of attribute "AXIdentifier" of depth1) as text
			end try
			set end of diag to "L1 " & d1Class & " | id=" & d1Id & " | name=" & d1Name & " | kids=" & (count of UI elements of depth1)
			repeat with depth2 in (UI elements of depth1)
				set d2Class to (class of depth2 as text)
				set d2Name to ""
				set d2Id to ""
				try
					set d2Name to (name of depth2) as text
				end try
				try
					set d2Id to (value of attribute "AXIdentifier" of depth2) as text
				end try
				set end of diag to "  L2 " & d2Class & " | id=" & d2Id & " | name=" & d2Name & " | kids=" & (count of UI elements of depth2)
				repeat with depth3 in (UI elements of depth2)
					set d3Class to (class of depth3 as text)
					set d3Name to ""
					set d3Id to ""
					try
						set d3Name to (name of depth3) as text
					end try
					try
						set d3Id to (value of attribute "AXIdentifier" of depth3) as text
					end try
					set end of diag to "    L3 " & d3Class & " | id=" & d3Id & " | name=" & d3Name
				end repeat
			end repeat
		end repeat

		return diag
	end tell
end tell
