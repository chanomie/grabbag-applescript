(*
 ** AdiumOffline **
 Useful to take your instant messengers offline at the end of the working day.
*)
if appIsRunning("Adium") then
	tell application "Adium"
		go offline
	end tell
	do shell script "/usr/local/bin/growlnotify -n 'Adium' -a 'Adium' -m 'Adium Close of Business'"
end if
if appIsRunning("Skype") then
	tell application "Skype"
		set status to send command "SET USERSTATUS OFFLINE" script name "Status Update"
	end tell
end if

on appIsRunning(appName)
	tell application "System Events" to (name of processes) contains appName
end appIsRunning