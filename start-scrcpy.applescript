-- Launch scrcpy mirroring for the device defined in config.env (path baked in by build.sh).

set scrcpyPath to "/opt/homebrew/bin/scrcpy"
set adbDir to "/opt/homebrew/bin"
set configPath to "__CONFIG_PATH__"

try
	set deviceSerial to do shell script "set -a; . " & quoted form of configPath & "; set +a; printf %s \"$DEVICE_SERIAL\""
on error
	display notification "Create config.env in the streamdeck repo with DEVICE_SERIAL=…" with title "scrcpy: config missing"
	return
end try

if deviceSerial is "" or deviceSerial is "YOUR_DEVICE_SERIAL_HERE" then
	display notification "Set DEVICE_SERIAL in " & configPath with title "scrcpy: serial missing"
	return
end if

do shell script "PATH=" & adbDir & ":$PATH nohup " & scrcpyPath & " -s " & quoted form of deviceSerial & " > /tmp/scrcpy.log 2>&1 &"
