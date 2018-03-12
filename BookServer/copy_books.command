fol=./_book/tutorials/Kwik4/Bookshelf
cd ~/Documents/Kwik/BookServer

root=$(pwd)

MyCopy(){
		cp copyright.txt ../$1/build4/assets/copyright.txt
		cp ../$1/build4/model.json  ../$1/build4/assets/model.json
		cp ../$1/*.mp3 ../$1/build4/assets/audios/
		cp ../$1/*.txt ../$1/build4/assets/audios/
		cd ../$1/build4
		mv assets $2
		zip -r ../assets.zip $2
		mv $2 assets
		cd $root
		mkdir -p $fol/$1
		cp ../$1/assets.zip $fol/$1/assets.zip
		cp ../$1/build4/assets/images/p1/bg.png  $fol/$1/bg.png
}

MyCopy Book01 book01
MyCopy Book02 book02
