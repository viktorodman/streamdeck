-- Dump AXIdentifier / AXHelp / AXTitle / AXDescription for every element in Control Centre,
-- so we can find a stable selector for the Screen Mirroring tile.

tell application "System Events"
	tell process "ControlCenter"
		click (first menu bar item of menu bar 1 whose description starts with "Control Cent")
		delay 0.6

		set output to {}
		set elems to entire contents of window 1

		repeat with i from 1 to count of elems
			set e to item i of elems
			set axId to ""
			set axHelp to ""
			set axTitle to ""
			set axDesc to ""
			try
				set axId to value of attribute "AXIdentifier" of e
			end try
			try
				set axHelp to value of attribute "AXHelp" of e
			end try
			try
				set axTitle to value of attribute "AXTitle" of e
			end try
			try
				set axDesc to value of attribute "AXDescription" of e
			end try
			set end of output to (i as text) & " " & (class of e as text) & " | id=" & (axId as text) & " | help=" & (axHelp as text) & " | title=" & (axTitle as text) & " | desc=" & (axDesc as text)
		end repeat

		return output
	end tell
end tell
