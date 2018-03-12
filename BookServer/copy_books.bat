set fol=.\bookshelf
cd %HOMEPATH%\Documents\Kwik\BookServer
call :MyCopyBgImg A_Direng_v1 book03
call :MyCopyBook A_Direng_v1 book03xh
exit /b

:MyCopyBook
echo MyCopyBook %1
copy  copyright.txt ..\%1\build4\assets\copyright.txt
copy ..\%1\build4\model.json  ..\%1\build4\assets\model.json
copy ..\%1\*.mp3 ..\%1\build4\assets\audios\
copy ..\%1\*.txt ..\%1\build4\assets\audios\
cd ..\%1\build4
move assets %2
rm ..\assets.zip
"C:\Program Files (x86)\Corona Labs\Corona SDK\7za.exe" a ..\assets.zip %2
move %2 assets
cd %~dp0
mkdir  %fol%\%2
copy ..\%1\assets.zip %fol%\%2\assets.zip
copy ..\%1\build4\assets\images\p1\bg.png  %fol%\%2\bg.png
exit /b

:MyCopyBgImg
echo MyCopyBgImg %1
cd %~dp0
mkdir  %fol%\%2
copy ..\%1\build4\assets\images\p1\bg.png  %fol%\%2\bg.png

exit /b