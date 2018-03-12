@echo off

set fol=.\_book\tutorials\Kwik4\Bookshelf
set proj=%HOMEPATH%\Documents\Kwik\BookShelfPages
cd %HOMEPATH%\Documents\Kwik\BookServer

rem rmdir /s /q BookServer

call :MyCopy Epsode02 4
call :MyCopy Epsode02 5
call :MyCopy Epsode03 6
exit /b

:MyCopy
echo %1
mkdir %fol%\%1
cd %fol%\%1
xcopy %proj%\build4\assets\images\p%2 assets\images\p%2 /D /S /R /Y /I /K
copy  %HOMEPATH%\Documents\Kwik\BookServer\copyright.txt assets\images\p%2
"C:\Program Files (x86)\Corona Labs\Corona SDK\7za.exe" a assets.zip assets
copy %proj%\build4\assets\images\p%2\bg.png bg.png
rmdir /s /q %proj%\build4\assets\images\p%2
cd  %~dp0
exit /b