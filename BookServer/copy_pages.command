fol=./bookshelf
proj=~/Documents/Kwik/BookshelfPages
root=$(pwd)

MyCopy(){
	mkdir -p $fol/Epsode0$1/assets/images/
	cp -R $proj/build4/assets/images/p$2 $fol/Epsode0$1/assets/images
	cp ~/Documents/Kwik/BookServer/copyright.txt $fol/Epsode0$1/assets/images/p$2
	cd $fol/Epsode0$1
	zip -r assets.zip assets
	cp $proj/build4/assets/images/p$2/bg.png .
	cd $root
	rm -d -R  $proj/build4/assets/images/p$2
}

MyCopy 2 4
MyCopy 2 5
MyCopy 3 6