@echo OFF
adb shell am start -n com.test.calc/com.test.calc.CalculatorActivity

echo..............................................
echo.
echo.
echo Simple script testing Calculator app
echo.
echo by Marcin Sikorski
echo.
echo..............................................
pause.
goto menu

:menu
cls
echo.
echo.
echo.	= Available tests =
echo.
echo.
echo [1] Add        :::   Press ADD button X times        :::
echo [2] Subtract   :::   Press SUB button X times        :::
echo [3] Min        :::   Minimize/maximize app X times   :::
echo [4] Monkey     :::   Run monkey test                 :::
echo [5] Kill       :::   Kill app                        :::
echo.
echo.
echo.
echo [0] Close this program       
echo.
echo.
set /p choice= Enter your number:

if '%choice%'=='1' goto Add
if '%choice%'=='2' goto Subtract
if '%choice%'=='3' goto Min
if '%choice%'=='4' goto Monkey
if '%choice%'=='5' goto Kill
if '%choice%'=='0' EXIT
---------------------------------------
:Add
cls
echo.
echo GIVEN I have opened app
echo WHEN I press ADD x times
echo THEN app won't crash
echo.
echo Press N to go back to menu
echo.
set /p n= How many times do it?

if '%n%'=='N' goto menu

for /L %%a IN (1,1,%n%) do (
	adb shell input tap 500 300
)
echo.
echo Press any button to go back to main menu
echo.
pause
goto menu

---------------------------------------
:Subtract
cls
echo.
echo GIVEN I have opened app
echo WHEN I press SUB x times
echo THEN app won't crash
echo.
echo Press N to go back to menu
echo.
set /p n= How many times do it?

if '%n%'=='N' goto menu

for /L %%a IN (1,1,%n%) do (
	adb shell input tap 500 400
)
echo.
echo Press any button to go back to main menu
pause
goto menu

---------------------------------------
:Min
cls
echo.
echo GIVEN I have opened app
echo WHEN I turn OFF/ON screen x times
echo AND I minimize/maximize screen x times
echo AND I turn OFF/ON screen x times
echo THEN app won't crash
echo.
echo Press N to go back to menu
echo.

set /p n= How many times do it?

if '%n%'=='N' goto menu

for /L %%a IN (1,1,%n%) do (
	adb shell input keyevent 26
	adb shell input keyevent 26
	adb shell input keyevent 3
	adb shell input keyevent 26
	adb shell input keyevent 26
	adb shell am start -n com.test.calc/com.test.calc.CalculatorActivity
	)
echo.
echo Press any button to go back to main menu
pause
goto menu

---------------------------------------
:Monkey
cls
echo.
echo GIVEN I have opened app
echo WHEN I run monkey test events x times
echo THEN app won't crash
echo.
echo Press N to go back to menu
echo.
set /p n= How many random events? (f.e. 5000 is a good starter)

if '%n%'=='N' goto menu

echo.
adb shell monkey -p com.test.calc -c android.intent.category.DEFAULT %n%

echo.
echo Press any button to go back to main menu
pause
goto menu

---------------------------------------
:Kill
cls
echo.
echo GIVEN I have opened app
echo WHEN I close app at any given moment
echo THEN App won't crash
echo.
echo [Y] Yes
echo [N] No
set /p choice= Do you want to close app?
echo.

if '%choice%'=='Y' adb shell pm clear com.test.calc
if '%choice%'=='N' goto menu