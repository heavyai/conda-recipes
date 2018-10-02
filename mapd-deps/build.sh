#!/bin/bash

export PKG_CONFIG_PATH=$BUILD_PREFIX/lib/pkgconfig
#LIBC_LIBDIR=/lib/`arch`-linux-gnu
#SYSTEM_PREFIX=/usr

LOCAL_PREFIX=$PREFIX

export CFLAGS="-I$BUILD_PREFIX/include $CFLAGS"
export CPPFLAGS="-I$BUILD_PREFIX/include $CPPFLAGS"
export CXXFLAGS="-I$BUILD_PREFIX/include $CXXFLAGS"
export LDFLAGS="-L$BUILD_PREFIX/lib $LDFLAGS"
export LDFLAGS="$LDFLAGS -Wl,-rpath,$BUILD_PREFIX/lib"

# Enable the following if-block when debugging:
DEBUG=true
if ! [ $DEBUG ]; then
  LOCAL_PREFIX=$RECIPE_DIR/local  # to cache succesful installations
  mkdir -p $LOCAL_PREFIX
fi
export CFLAGS="-I$LOCAL_PREFIX/include $CFLAGS"
export CPPFLAGS="-I$LOCAL_PREFIX/include $CPPFLAGS"
export CXXFLAGS="-I$LOCAL_PREFIX/include $CXXFLAGS"
export LDFLAGS="-L$LOCAL_PREFIX/lib $LDFLAGS"
# needed when building mapd-core
export LDFLAGS="$LDFLAGS -Wl,-rpath,$LOCAL_PREFIX/lib"

# fix include file issues when building llvm/lldb:
CXXFLAGS="-I$LOCAL_PREFIX/include/ncurses -I$LOCAL_PREFIX/include/libxml2 $CXXFLAGS"

export CFLAGS="-fPIC $CFLAGS"
export CPPFLAGS="-fPIC $CPPFLAGS"
export CXXFLAGS="-fPIC $CXXFLAGS"

PYTHON=$SYS_PYTHON
PYTHON_INCLUDE_DIR=$($PYTHON -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())")
PYTHON_LIBRARY=$($PYTHON -c "import distutils.sysconfig as sc;print('{LIBDIR}/{LDLIBRARY}'.format_map(sc.get_config_vars()))")
echo "PYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR"
echo "PYTHON_LIBRARY=$PYTHON_LIBRARY"

# TODO: not sure that this works on runtime..
# allow arrow cmake to find pthread library:
PTHREAD_INCLUDE_DIR=$BUILD_PREFIX/$BUILD/sysroot/usr/include/
PTHREAD_LIBRARY=$BUILD_PREFIX/$BUILD/sysroot/lib/libpthread.so.0

# glog does not compile with c++17, so downgrading to c++14:
export CXXFLAGS=$($PYTHON -c "print(\"$CXXFLAGS\".replace(\"-std=c++17\", \"-std=c++14\"))")
export DEBUG_CXXFLAGS=$($PYTHON -c "print(\"$DEBUG_CXXFLAGS\".replace(\"-std=c++17\", \"-std=c++14\"))")

echo "CXXFLAGS=$CXXFLAGS"
echo "DEBUG_CXXFLAGS=$DEBUG_CXXFLAGS"

export OPENSSL_PREFIX=$LOCAL_PREFIX
export PATH=$LOCAL_PREFIX/bin:$PREFIX/bin:$PATH
#export LD_LIBRARY_PATH=$LIBC_LIBDIR:$LD_LIBRARY_PATH
#export LD_LIBRARY_PATH=$SYSTEM_PREFIX/lib64:$SYSTEM_PREFIX/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$LOCAL_PREFIX/lib64:$LOCAL_PREFIX/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=$PREFIX/lib64:$PREFIX/lib:$LD_LIBRARY_PATH

#
# Install packages from source
#

GMP_VERSION=6.1.2
MPFR_VERSION=3.1.5
MPC_VERSION=1.0.3
GCC_VERSION=5.5.0
CMAKE_VERSION=3.7.2

EXPAT_VERSION=2.2.0
ZLIB_VERSION=1.2.8

OPENSSL_VERSION=1.0.2n
CURL_VERSION=7.50.0
BOOST_VERSION=1_62_0
LIBEVENT_VERSION=2.0.22
BISONPP_VERSION=1.21
LIBARCHIVE_VERSION=3.3.2

GFLAGS_VERSION=2.2.0
GLOG_VERSION=0.3.4
FOLLY_VERSION=2017.10.16.00

LIBKML_VERSION=1.3.0
PROJ_VERSION=4.9.3
GDAL_VERSION=2.2.4

THRIFT_VERSION=0.10.0

AWSCPP_VERSION=1.3.10
RAPIDJSON_VERSION=1.1.0
FLATBUFFERS_VERSION=1.7.1
ARROW_VERSION=0.7.1
LLVM_VERSION=3.9.1
MAPDCORE_VERSION=3.6.0

source $RECIPE_DIR/packages.sh
source $RECIPE_DIR/rules.sh
source $RECIPE_DIR/apply-rules.sh
