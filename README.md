# CaffeMaker
Recommended Usage:

1. Download zip from Github.
2. Unzip file.
3. Enter the unzipped directory.
4. Make sure make-caffe.sh is executable
5. Make necessary changes to Makefile and Makefile.config
6. Run make-caffe.sh

Necessary Changes To Caffe:
+ add the following lines to the Makefile:
    + CXXFLAGS += -Ipath/to/hdf5-1.8.18/src
    + CXXFLAGS += -Ipath/to/hdf5-1.8.18/hl/src
    + CXXFLAGS += -Ipath/to/hdf5-1.10.0.patch/hl/src

+ make the following changes to Makefile.config:
    + uncomment CPU_ONLY := 1 (if using only CPU)
    + uncomment USE_OPENCV := 0 (if usinig only CPU)
    + change BLAS_INCLUDE to /usr/local/include/atlas and uncomment


This installer has been tested on the following environments:
+ Ubuntu 16.04 

Uses Caffe commit 24d2f67

Dependencies:
+ m4 (Version 1.4.9)
+ autoreconf (Version 2.69)
+ libtool (Version 2.4.6)
+ automake (Version 1.15)
+ cmake (Version 3.7.0)
+ boost (Version 1.60.0) *
+ atlas *
+ hdf5 *
+ protobuf (Version 3.1.0) *
+ glog (Version 0.3.4) *
+ gflags (Version 2.2.0) *
+ levelDB (Version 1.2) *
+ lmdb (Version 2.8) *
+ snappy (Version 1.1.3) *
Note: It is assumed that the dependencies marked with asteriks are NOT
already installed. There is no check for the existence of these dependencies
before install.

Pull requests to this tool are kindly accepted. If you test on a new
environment, please add it to the list.
