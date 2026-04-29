tell application "System Events"
	tell process "ControlCenter"
		click (first menu bar item of menu bar 1 whose description starts with "Control Cent")

		-- Poll for AX tree to populate
		set elemCount to 0
		set t to 0
		repeat until elemCount > 10 or t ≥ 5
			delay 0.2
			set t to t + 0.2
			try
				set elemCount to count of (entire contents of window 1)
			end try
		end repeat

		set smTile to missing value
		repeat with e in (entire contents of window 1)
			try
				if (class of e) is checkbox then
					if (value of attribute "AXIdentifier" of e) is "controlcenter-screen-mirroring" then
						set smTile to contents of e
						exit repeat
					end if
				end if
			end try
		end repeat

		if smTile is missing value then return "ERR: not found. elems=" & elemCount

		click smTile
		delay 0.8

		set output to {"opened. windows=" & (count of windows)}
		repeat with w from 1 to count of windows
			set end of output to "--- window " & w & " ---"
			try
				set elems to entire contents of window w
				set end of output to "  elems=" & (count of elems)
				set idx to 0
				repeat with e in elems
					set idx to idx + 1
					set axId to ""
					set axName to ""
					set axTitle to ""
					try
						set axId to (value of attribute "AXIdentifier" of e) as text
					end try
					try
						set axName to (name of e) as text
					end try
					try
						set axTitle to (value of attribute "AXTitle" of e) as text
					end try
					set end of output to idx & " " & (class of e as text) & " | id=" & axId & " | name=" & axName & " | title=" & axTitle
				end repeat
			end try
		end repeat

		return output
	end tell
end tell
