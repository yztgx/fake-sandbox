@echo off
TITLE Fake-sandbox processes updater

start /MIN powershell -executionpolicy remotesigned -WindowStyle Hidden -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Aperture-Diversion/fake-sandbox/master/updater/version', '%appdata%\Fake-Sandbox Processes\version.txt')"
ping -n 2 localhost>NUL

if version.txt == 1.3 (goto ok)
goto new

:new
del version.txt
SET type version.txt=%version%
* msg A new version (%version%) of FSP (fake-sandbox processes) is available!
SET /P ANSWER=Would you like to install the update? (y/n): 
if /i %ANSWER%==y (goto install)
if /i %ANSWER%==n (goto no)
goto unrecog

:install
cls
echo.
echo Installing new files...
start /MIN powershell -executionpolicy remotesigned -WindowStyle Hidden -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Aperture-Diversion/fake-sandbox/master/updater/fake-sandbox.bat', '%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\fake-sandbox.bat')"
start /MIN powershell -executionpolicy remotesigned -WindowStyle Hidden -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Aperture-Diversion/fake-sandbox/master/updater/fake-sandbox.ps1', '%appdata%\Fake-Sandbox Processes\fake-sandbox.ps1')"
ping -n 3 localhost>NUL
cls
COLOR 0A
echo.
echo Done. Please relogin for the changes to take effect. Click to close this window...
echo.
pause>NUL
exit

:no
cls
echo.
echo You chose not to install the update. Press any key to exit...
echo.
pause>NUL
exit

:ok
del version.txt
exit

:unrecog
COLOR 0C
cls
echo.
echo An error occured!
echo Unrecognized command. You have to choose "y" for yes and "n" for no.
echo.
echo Press any key to exit...
echo.
pause > NUL
exit
