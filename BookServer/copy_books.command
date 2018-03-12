fol=./bookshelf
root=$(pwd)

MyCopy(){
		cp copyright.txt ../$1/build4/assets/copyright.txt
		cp ../$1/build4/model.json  ../$1/build4/assets/model.json
		cp ../$1/*.mp3 ../$1/build4/assets/audios/
		cp ../$1/*.txt ../$1/build4/assets/audios/
		cd ../$1/build4
		mv assets $2$3
		zip -r ../assets.zip $2$3
		mv $2$3 assets
		cd $root
		mkdir -p $fol/$2$3
		rm $fol/$2$3/assets.zip
		cp ../$1/assets.zip $fol/$2$3/assets.zip
		cp ../$1/build4/assets/images/p1/bg.png  $fol/$2$3/bg.png
		if [ "$4" = "true" ]; then
			mkdir -p $fol/$2
			cp ../$1/build4/assets/images/p1/bg.png  $fol/$2/bg.png
		fi
}

MyCopy A_Direng_v1 book03 xh true
# MyCopy Book02 book02
# MyCopy Book01en book01en
# MyCopy Book01jp book01jp
# MyCopy Book01sp book01sp
# MyCopy Book02en book02en
# MyCopy Book02jp book02jp
