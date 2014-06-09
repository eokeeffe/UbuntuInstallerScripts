#
#	Created by Evan O'Keeffe
#	27 May 2014
#	Installs V1.8.1 of openMPI
#	Verified working on Ubuntu 14.04
#	Urban Modelling Group

# Build using maximum number of physical cores
n=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{print $NF}'`
 
echo $n

# grab the necessary files
wget http://www.open-mpi.org/software/ompi/v1.8/downloads/openmpi-1.8.1.tar.gz
tar xzvf openmpi-1.8.1.tar.gz
cd openmpi-1.8.1

mkdir buid
cd build
../configure
make -j $n all
make install

# this fixes the problem where libopen-pal.so.x shared library cannot be
# found
echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib" >> ~/.bashrc