set fol=.\bookshelf
cd %HOMEPATH%\Documents\Kwik\BookServer
call :MyCopy A_Direng_v1 book03 xh true
exit /b

:MyCopy
echo MyCopy %1
copy  copyright.txt ..\%1\build4\assets\copyright.txt
copy ..\%1\build4\model.json  ..\%1\build4\assets\model.json
copy ..\%1\*.mp3 ..\%1\build4\assets\audios\
copy ..\%1\*.txt ..\%1\build4\assets\audios\
cd ..\%1\build4
move assets %2%3
rm ..\assets.zip
"C:\Program Files (x86)\Corona Labs\Corona SDK\7za.exe" a ..\assets.zip %2%3
move %2%3 assets
cd %~dp0
mkdir  %fol%\%2%3
copy ..\%1\assets.zip %fol%\%2%3\assets.zip
copy ..\%1\build4\assets\images\p1\bg.png  %fol%\%2%3\bg.png
echo %4
if "%4"=="true" (
  mkdir  %fol%\%2
  copy ..\%1\build4\assets\images\p1\bg.png  %fol%\%2\bg.png
)

exit /b