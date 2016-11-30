#!/bin/bash

# get autoreconf, if necessary
if (type autoreconf 2>/dev/null) then
    echo "autoreconf detected"
else
    echo "Installing autoconf"
    cd autoconf-2.69
    chmod configure
    ./configure
    make; make install
    echo "autoconf installed"
fi
exit
# Protobuf
cd protobuf
chmod +x autogen.sh
ls
./autogen.sh
chmod +x configure
#./configure
#make clean
#make
#make check
#sudo make install
#cd ..
#
##boost
#cd boost_1_60_0 
## Must force disable float 128 support
## by removing #ifdef/#endif around BOOST_MATH_DISABLE_FLOAT128 in
## boost/math/tools/config.hpp
#./bootstrap.sh
#./bjam install
#cd ..
#
## glog
#cd glog
#chmod +x configure
#./configure
#./make
#./sudo make install
#cd ..
#
## cmake
#cd cmake-3.7.0
#chmod +x bootstrap
#./bootstrap
#make
#make install
#cd ..
#
## gflags
#cd gflags
#mkdir build
#cd build
#cmake ..
#make
#make install
#cd ..
#
## ATLAS
#cd ATLAS
#chmod +x configure
#mkdir build
#cd build
## cripple-atlas-performance necessary for because of Atom
#../configure --shared -b 32 --nof77 --cripple-atlas-performance
#make
#make install
#cp lib/*.so /usr/local/lib
#cp lib/*.a /usr/local/lib
#cd ..
#mkdir /usr/local/include/atlas
#cp -r include/* /usr/local/include/atlas
#cd ..
#
## hdf5
#cd hdf5-1.8.18 
#./configure --prefix=/usr/local/hdf5
#make
#make install
#cp hl/src/.libs/*.a /usr/local/lib
#cp h1/src/.libs/*.so /usr/local/lib
#cp src/.libs/*.a /usr/local/lib
#cp src/.libs/*.so /usr/local/lib
#cd ..
#
## LevelDB
#cd leveldb
#make
#sudo cp out-shared/libleveldb.* /usr/local/lib
#cd include
#sudo cp -R leveldb /usr/local/include
#cd ../..
#
## LMDB
#cd lmdb/libraries/liblmdb
#make
#make install
#cd ../../..
#
## Snappy
#cd snappy
#chmod +x ./autogen.sh
#./autogen.sh
#chmod +x ./configure
#./configure
#make; make install
#cd ..
#
## Caffe
#cd caffe
#make all
#make test
#make runtest
#cd ..
