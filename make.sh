#!/usr/bin/env bash

sudo apt-get install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libboost-all-dev libhdf5-serial-dev libatlas-base-dev;

mkdir 3rdparty;
cd 3rdparty;

# glog
wget https://google-glog.googlecode.com/files/glog-0.3.3.tar.gz
tar zxvf glog-0.3.3.tar.gz
cd glog-0.3.3
./configure
make && sudo make install
cd ..;

# gflags
git clone https://github.com/gflags/gflags.git;
cd gflags;
git checkout d4e971c10b1557292b5371807a23921d15e7fece .;
mkdir build && cd build
export CXXFLAGS="-fPIC" && cmake .. && make VERBOSE=1
make && sudo make install
cd ../..

# lmdb
git clone https://gitorious.org/mdb/mdb.git
cd mdb/libraries/liblmdb
make && sudo make install
cd ../../..

cd ..;
if [ ! -e "Makefile.config" ];
then
    cp Makefile.config.example Makefile.config;
fi
CPU_ONLY=1 make;

