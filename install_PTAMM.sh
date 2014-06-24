#!/bin/bash
#
# A quick hack to compile PTAMM (04/04/2013) on Ubuntu12.04LTS
# 
# This script is modified from KAMEDA, Yoshinari
#
# Bingxiong Lin 
# bingxiong@mail.usf.edu
# http://www.cse.usf.edu/~bingxiong/personal.html

targettopdir=$HOME/PTAM-work
pwdinfo=`pwd`

# OpenCV?
echo "--------------------------------------------------------------"
echo "Do you have OpenCV 2.4.4 ? If not, stop here and prepare that."
echo "Check: http://www.cse.usf.edu/~bingxiong/documents/opencv_2_4_4.sh for opencv installation"
echo "--------------------------------------------------------------"
sleep 10


echo "----------------------------------------------------------"
echo "liblapack-dev freeglut3-dev, and libdc1394-22-dev are required."
echo "-----------------------------------------------------------"
sleep 10
sudo apt-get install liblapack-dev freeglut3-dev libdc1394-22-dev

export CVS_RSH=ssh

# video output for linux
sudo apt-get install mencoder

mkdir -p $targettopdir

# TooN
echo "------------------------------------"
echo "Installing Toon in 3 seconds..."
echo "------------------------------------"
sleep 3
pushd $targettopdir
#cvs -z3 -d:pserver:anonymous@cvs.savannah.nongnu.org:/sources/toon co -D "Mon May 11 16:29:26 BST 2009" TooN
#cd TooN
echo "Downloading TooN"
wget http://www.edwardrosten.com/cvd/TooN-2.1.tar.bz2
tar -xvf TooN-2.1.tar.bz2
cd Toon-2.1/
echo "Compiling TooN"
./configure
sudo make install
popd

# libcvd
echo "--------------------------------------"
echo "Installing libcvd in 3 seconds..."
echo "--------------------------------------"
sleep 3
pushd $targettopdir
#cvs -z3 -d:pserver:anonymous@cvs.savannah.nongnu.org:/sources/libcvd co -D "Mon May 11 16:29:26 BST 2009" libcvd
#cd libcvd
#mv cvd_src/convolution.cc cvd_src/convolution.cc-original
#cp $pwdinfo/hack/libcvd/convolution.cc cvd_src/convolution.cc
echo "Downloading libcvd"
wget http://www.edwardrosten.com/cvd/libcvd-20121025.tar.bz2
tar -xvf libcvd-20121025.tar.bz2
cd libcvd-20121025/
echo "Compiling libcvd"
export CXXFLAGS=-D_REENTRANT
./configure --without-ffmpeg
make
sudo make install
popd

# gvars3
echo "---------------------------------------"
echo "Installing gvars3 in 3 seconds ..."
echo "---------------------------------------"
sleep 3
pushd #$targettopdir
#cvs -z3 -d:pserver:anonymous@cvs.savannah.nongnu.org:/sources/libcvd co -D "Mon May 11 16:29:26 BST 2009" gvars3
#cd gvars3
#mv gvars3/serialize.h gvars3/serialize.h-original
#cp $pwdinfo/hack/gvars3/serialize.h gvars3/serialize.h
echo "Downloading Gvars3"
wget http://www.edwardrosten.com/cvd/gvars-3.0.tar.bz2
tar -xvf gvars-3.0.tar.bz2
cd gvars-3.0
echo "Compiling Gvars3"
./configure --disable-widgets
make
sudo make install
popd

# lib3ds
echo "---------------------------------------"
echo "Installing lib3ds in 3 seconds ..."
echo "---------------------------------------"
sleep 3
pushd $HOME/PTAM-work #$targettopdir
echo "Downloading lib3ds"
wget http://lib3ds.googlecode.com/files/lib3ds-20080909.zip
unzip lib3ds-20080909.zip
cd lib3ds-20080909/
echo "Compiling lib3ds"
./configure
make
sudo make install
popd


# before you go further, re-arrange the dynamic libraries
sudo ldconfig

# PTAMM main
echo "--------------------------------------"
echo "Start compiling PTAMM in 10 seconds ..."
echo "YOU NEED TO AGREE WITH THEIR LICENSE !"
echo "--------------------------------------"
sleep 5
unzip ptamm.zip
mv PTAMM $HOME/PTAM-work
pushd $HOME/PTAM-work #$targettopdir
cd PTAMM
cp Build/Linux/Makefile Makefile
cp Build/Linux/VideoSource_Linux_V4L.cc VideoSource_Linux_V4L.cc
make
popd


exit 0
