# CaffeMaker
Github-based Dependencies:
protobuf
glog
gflags
levelDB
lmdb
snappy

Other Dependencies:
cmake
autoreconf
boost
atlas
hdf5

Necessary Changes To Caffe:
+ add the following lines to the Makefile:
    CXXFLAGS += -I<path/to/hdf5-1.8.18/src>
    CXXFLAGS += -I<path/to/hdf5-1.8.18/hl/src>
    CXXFLAGS += -i<path/to/hdf5-1.10.0.patch/hl/src>

+ make the following changes to Makefile.config:
    uncomment CPU_ONLY := 1 (if using only CPU)
    uncomment USE_OPENCV := 0 (if usinig only CPU)
    change BLAS_INCLUDE to /usr/local/include/atlas and uncomment

