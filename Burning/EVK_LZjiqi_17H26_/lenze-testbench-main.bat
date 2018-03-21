echo OFF
setlocal enabledelayedexpansion
echo ############################################
echo ##---- lenze   Evktestbench tools 2.0---- ##
echo ############################################
echo   author:xiaodong.zong  [version:2013-06-15]
echo --------------------------------------------

cd platform
:RETRY
echo 	the platform list=:
echo 	[
for  /d  %%i  in (*)  do echo 	%%i
echo 	]
echo input the name of platform(the name in the platform list):
set /p cur_sel= 

for  /d  %%i  in (*)  do (
IF %%i==%cur_sel%  goto CFGBEGIN
)
echo please select the platform in list!!
echo press "ENTER" to retry...
pause>nul
goto RETRY
:CFGBEGIN

cd %cur_sel%

echo do you want to write test_bench to EVK board? yes/no
set answer=no 
set /p answer=

IF "%answer%" == "yes" (
..\..\tcdb2.exe  tcfg
for %%1 in ("test.cfg") do if %%~z1 GTR 184320 (
	echo bin file too big,exceed,ERR! 
	echo bin file too big,exceed,ERR! 
	echo bin file too big,exceed,ERR! 
	pause
	goto END
)
..\..\tcdb.exe  wf 10000 -ebu -i test.cfg
 ..\..\tcdb.exe  wf 0 -ebu -i ..\..\testbench_evk.bin
echo  test_bench bin file write done!
)
 

echo do you want to write config parameter to EVK board? yes/no
set answer=no
set /p answer=

IF "%answer%" == "yes" (
rem set /p boardnumber="<board number>:"
..\..\loadcfg.exe  ".\\product.ini"  "..\..\tcdb.exe" "255"
call setcfg.bat
echo  config parameter write done!
)


echo do you want to write frequenty compensation for the EVK board? yes/no
set answer=no
set /p answer=

IF "%answer%" == "yes" (
..\..\fre_comp.exe  ".\\product.ini"  "..\..\tcdb.exe"
call  calc_fre.bat
echo  frequent compensation done!

)


echo "## config done, please restart the EVK hardware..."
pause

rem .\tcdb.exe tcfg
rem .\tcdb.exe wf 5000 -ebu -i test.cfg
rem .\tcdb.exe wf 0 -ebu -i ..\testbench_evk.bin
:END