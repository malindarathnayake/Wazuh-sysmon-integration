cmd.exe /c "Sysmon64 -u force 2>&1"
cmd /c "net stop Sysmon64 2>&1"
cmd /c "net stop sysmondrv 2>&1"
Remove-Item -Path "C:\Windows\Sysmon64.exe" -Force
Remove-Item -Path "C:\Windows\SysmonDrv.sys" -Force
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\SysmonDrv" -Recurse -Force
Remove-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Sysmon64" -Recurse -Force
fltmc unload SysmonDrv
cmd /c "sc delete sysmon64"
cmd /c "sc delete sysmondrv"

#please reboot after this
