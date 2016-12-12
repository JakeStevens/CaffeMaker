# CaffeMaker

CaffeMaker was created primarily for use in an integrated Intel + FPGA environment
running an embedded Linux distro, specifically the DE2-150 board from Altera.
By following the recommended usage, you can easily and quickly build Caffe on
your FPGA platform, allowing for the design and benchmarking of accelerators
for Deep Learning.

Recommended Usage:

1. Download zip from Github.
2. Unzip file.
3. Enter the unzipped directory.
4. Make sure make-caffe.sh is executable
5. Make sure that the install for boost in make-caffe.sh is correct (32 v 64)
6. Make necessary changes to Makefile.config
6. Run make-caffe.sh

To check your installation of Caffe after the make script finishes without errors,
you can do the following from the root directory of caffe to run a trained LeNet
network on the MNIST dataset:

```
chmod +x ./examples/mnist/create_mnist.sh
./examples/mnist/create_mnist.sh
./build/tools/caffe test --model ./examples/mnist/lenet_train_test.prototxt  --weights ../lenet_iter_10000.caffemodel --iterations 100
```


Necessary Changes To Caffe:
+ copy Makefile.config.example to Makefile.config

+ make the following changes to Makefile.config:
    + uncomment CPU_ONLY := 1 (if using only CPU)
    + uncomment USE_OPENCV := 0 (if usinig only CPU)
    + change BLAS_INCLUDE to /usr/local/include/atlas and uncomment


This installer has been tested on the following environments:
+ Ubuntu 16.04 
+ Yocto

Uses Caffe commit 24d2f67

Dependencies:
+ m4 (Version 1.4.9)
+ autoreconf (Version 2.69)
+ libtool (Version 2.4.6)
+ automake (Version 1.15)
+ cmake (Version 3.7.0)
+ zlib (Version 1.2.8) *
+ boost (Version 1.60.0) *
+ atlas *
+ hdf5 *
+ protobuf (Version 3.1.0) *
+ glog (Version 0.3.4) *
+ gflags (Version 2.2.0) *
+ levelDB (Version 1.2) *
+ lmdb (Version 2.8) *
+ snappy (Version 1.1.3) *

If you are updating the dependencies, make sure that:
+ data/ and models/ are removed from the .gitignore for Caffef
+ ./autogen.sh files are removed from the .gitignore for protobuff
+ ./autogen.sh is ran for protobuff (not all embedded Linux distros
have curl)
+ If you update Caffe, you may have to edit the path to hdf5 inside
the header file. You will know you need to if it errors out and lets
you know..

Note: the code that does a PKG_CHECK on snappy (inside configure file)
has been removed. This is checking for gflags, which must be installed
anyways

Note: It is assumed that the dependencies marked with asteriks are NOT
already installed. There is no check for the existence of these dependencies
before install.

Please note: this installer is intended for environments in which the
installer has sudo permissions and Caffe is the sole intended application.
It currently does NOT play nice with its installation of the asteriked
dependencies and can easily clobber existing installations of them. Would be a
nice upgrade.

Pull requests to this tool are kindly accepted. If you test on a new
environment, please add it to the list.
