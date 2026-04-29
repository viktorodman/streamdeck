-- Launch scrcpy mirroring for the device defined in ~/.streamdeck-scrcpy.env

set scrcpyPath to "/opt/homebrew/bin/scrcpy"
set adbDir to "/opt/homebrew/bin"
set configPath to "$HOME/.streamdeck-scrcpy.env"

try
	set deviceSerial to do shell script "set -a; . " & configPath & "; set +a; printf %s \"$DEVICE_SERIAL\""
on error
	display notification "Create ~/.streamdeck-scrcpy.env with DEVICE_SERIAL=…" with title "scrcpy: config missing"
	return
end try

if deviceSerial is "" or deviceSerial is "YOUR_DEVICE_SERIAL_HERE" then
	display notification "Set DEVICE_SERIAL in ~/.streamdeck-scrcpy.env" with title "scrcpy: serial missing"
	return
end if

do shell script "PATH=" & adbDir & ":$PATH nohup " & scrcpyPath & " -s " & quoted form of deviceSerial & " > /tmp/scrcpy.log 2>&1 &"
