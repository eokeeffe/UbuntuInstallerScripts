#!/bin/bash
 
openMVGDir=openMVG
openMVGSrcDir=../openMVG/src
openMVG_BuildDir=openMVG_Build
 
installLibraries(){
	echo 
	echo "Installing necessary libraries..."
	sudo apt-get install libpng-dev libjpeg-dev libxxf86vm1 libxxf86vm-dev libxi-dev libxrandr-dev
	sudo apt-get install python-sphinx 
}
 
 
clearInstallation(){	
	
	if [ -d $openMVGDir ] || [ -d $openMVG_BuildDir ]; then
		echo
		echo "Removing old installation..."
	fi
	if [ -d $openMVGDir ]; then
		rm -rf $openMVGDir
	fi
	if [ -d $openMVG_BuildDir ]; then
		rm -rf $openMVG_BuildDir
	fi
}
 
 
 
cloneGitHub(){
	echo 
	echo "Cloning OpenMVG from Gihhub..."
	git clone https://github.com/openMVG/openMVG.git
	cd $openMVGDir
	git checkout develop
	git submodule init
	git submodule update
	cd ..
}
 
compileOpenMVGForEclipse(){
	echo
	echo "Compiling OpenMVG..."
	mkdir $openMVG_BuildDir
	cd $openMVG_BuildDir
 
	
	cmake -G "Eclipse CDT4 - Unix Makefiles" -DCMAKE_BUILD_TYPE=RELEASE . $openMVGSrcDir
	
	make # use make -j number_of_cores instead to use multiple cores
 
	cd ..
}
 
testOpenMVG(){
	echo
	echo "Testing..."
	cd $openMVG_BuildDir
	make test
	cd ..
}
 
installLibraries
clearInstallation
cloneGitHub
compileOpenMVGForEclipse
testOpenMVG
echo
echo "Ready."
$SHELL
