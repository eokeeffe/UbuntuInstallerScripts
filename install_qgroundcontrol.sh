sudo apt-get install libqt4-dev libphonon-dev libphonon4 phonon-backend-gstreamer qtcreator libsdl1.2-dev build-essential libudev-dev

sudo apt-get install espeak libespeak-dev

git clone https://github.com/mavlink/qgroundcontrol.git

cd qgroundcontrol
qmake -qt4
make -j 2

echo "QGroundControl is now installed succesfully"