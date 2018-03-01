echo OFF
:START
echo telink-script: start :
.\tcdb.exe wc -u 0 0
echo press "ENTER" to restart...
pause>nul
goto START