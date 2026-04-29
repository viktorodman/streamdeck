-- Kill running scrcpy session for the device defined in config.env (path baked in by build.sh).

set configPath to "__CONFIG_PATH__"

try
	set deviceSerial to do shell script "set -a; . " & quoted form of configPath & "; set +a; printf %s \"$DEVICE_SERIAL\""
on error
	return
end try

if deviceSerial is "" then return

try
	do shell script "pkill -f " & quoted form of ("scrcpy.*" & deviceSerial)
end try
