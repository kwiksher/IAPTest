fol=./_book/tutorials/Kwik4/Bookshelf
proj=~/Documents/Kwik/BookshelfPages
cd ~/Documents/Kwik/BookServer
root=$(pwd)

MyCopy(){
	mkdir -p $fol/$1/assets/images/
	cp -R $proj/build4/assets/images/p$2 $fol/$1/assets/images
	cp ~/Documents/Kwik/BookServer/copyright.txt $fol/$1/assets/images/p$2
	cd $fol/$1
	zip -r assets.zip assets
	cp $proj/build4/assets/images/p$2/bg.png .
	cd $root
	rm -d -R  $proj/build4/assets/images/p$2
}

MyCopy Epsode02 4
MyCopy Epsode02 5
MyCopy Epsode03 6