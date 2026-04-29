-- Open System Settings → Displays and dump the UI tree so we can find
-- the "+" / "Add Display" dropdown and target the iPad entry.

do shell script "open 'x-apple.systempreferences:com.apple.Displays-Settings.extension'"
delay 1.8

tell application "System Events"
	tell process "System Settings"
		set frontmost to true
		delay 0.3

		set output to {}
		set winCount to count of windows
		set end of output to "windows=" & winCount

		repeat with w from 1 to winCount
			set end of output to "--- window " & w & " ---"
			try
				set elems to entire contents of window w
				repeat with i from 1 to count of elems
					set e to item i of elems
					set axId to ""
					set axTitle to ""
					set axDesc to ""
					set axName to ""
					try
						set axId to value of attribute "AXIdentifier" of e
					end try
					try
						set axTitle to value of attribute "AXTitle" of e
					end try
					try
						set axDesc to value of attribute "AXDescription" of e
					end try
					try
						set axName to (name of e) as text
					end try
					set end of output to (i as text) & " " & (class of e as text) & " | id=" & (axId as text) & " | name=" & axName & " | title=" & (axTitle as text) & " | desc=" & (axDesc as text)
				end repeat
			end try
		end repeat

		return output
	end tell
end tell
