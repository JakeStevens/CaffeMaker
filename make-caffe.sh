#!/bin/bash

# get m4, if necessary
if (type m4 >/dev/null 2>&1) then
    echo "m4 detected"
else
    echo "Installing m4"
    cd m4-1.4.9
    chmod +x configure
    sudo ./configure; sudo make; sudo make install; 
    echo "m4 installed"
    cd ..
fi

# get autoreconf, if necessary
if (type autoreconf >/dev/null 2>&1) then
    echo "autoreconf detected"
else
    echo "Installing autoconf"
    cd autoconf-2.69
    chmod +x configure
    ./configure
    sudo make; sudo make install
    echo "autoconf installed"
    cd ..
fi

# get libtool, if necessary
if (type libtool >/dev/null 2>&1) then
    echo "libtool detected"
else
    echo "Installing libtool"
    cd libtool-2.4.6
    chmod +x configure
    ./configure
    sudo make; sudo make install
    echo "libtool installed"
    cd ..
fi

# get automake, if necessary
if (type automake >/dev/null 2>&1) then
    echo "automake detected"
else
    echo "Installing automake"
    cd automake-1.15
    chmod +x configure
    ./configure
    sudo make; sudo make install
    echo "automake installed"
    cd ..
fi


# get cmake, if necessary
if (type cmake > /dev/null 2>&1) then
    echo "cmake detected"
else
    echo "Installing cmake"
    cd cmake-3.7.0
    chmod +x bootstrap
    ./bootstrap
    sudo make
    sudo make install
    cd ..
fi

# Protobuf
cd protobuf
touch aclocal.m4 configure Makefile.in Makefile.am
./configure
make clean
make
make check
sudo make install
cd ..

# boost
cd boost_1_60_0 
chmod +x ./tools/build/src/engine/build.sh
# Must force disable float 128 support
# by removing #ifdef/#endif around BOOST_MATH_DISABLE_FLOAT128 in
# boost/math/tools/config.hpp
./bootstrap.sh
sudo ./bjam install
cd ..

# glog
cd glog
mkdir build
cd build
export CXXFLAGS="-fPIC"
sudo cmake -DBUILD_SHARED_LIBS=true .. 
make
sudo make install
cd ../..

# gflags
cd gflags
mkdir build
cd build
export CXXFLAGS="-fPIC"
sudo cmake -DBUILD_SHARED_LIBS=true ..
make
sudo make install
cd ../..

# ATLAS
cd ATLAS
mkdir build
cd build
# cripple-atlas-performance necessary for because of Atom
# change 32 to reflect specific machine (aka, 32 or 64)
../configure --shared --dylibs -b 64 --nof77 --cripple-atlas-performance
chmod +x bin/ATLrun.sh
make
sudo make install
sudo cp lib/*.so /usr/local/lib
sudo cp lib/*.a /usr/local/lib
cd ..
sudo mkdir /usr/local/include/atlas
sudo cp -r include/* /usr/local/include/atlas
cd ..


# zlib
cd zlib-1.2.8
./configure
make
sudo make install
cd ..
 
# hdf5
cd hdf5-1.10.0-patch1 
./configure --enable-cxx --prefix=/usr/local/
make
sudo make install
cd ..

# LevelDB
cd leveldb
make
sudo cp out-shared/libleveldb.* /usr/local/lib
cd include
sudo cp -R leveldb /usr/local/include
cd ../..

# LMDB
cd lmdb/libraries/liblmdb
make
sudo make install
cd ../../..

# Snappy
cd snappy-1.1.3
./configure
make; sudo make install
cd ..

# Caffe
cd caffe
make all
make test
make runtest
cd ..

sudo ldconfig
