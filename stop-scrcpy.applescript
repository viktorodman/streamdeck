-- Kill running scrcpy session for the device defined in ~/.streamdeck-scrcpy.env

set configPath to "$HOME/.streamdeck-scrcpy.env"

try
	set deviceSerial to do shell script "set -a; . " & configPath & "; set +a; printf %s \"$DEVICE_SERIAL\""
on error
	return
end try

if deviceSerial is "" then return

try
	do shell script "pkill -f " & quoted form of ("scrcpy.*" & deviceSerial)
end try
