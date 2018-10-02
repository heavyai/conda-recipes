case $GMP_RULE in
skip) ;;
source)
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/gmp-$GMP_VERSION.tar.xz \
    "" "--enable-fat" $LOCAL_PREFIX/include/gmp_h
  ;;
*) echo "GMP_RULE NOTIMPL: $GMP_RULE"
esac

case $MPFR_RULE in
skip) ;;
source)
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/mpfr-$MPFR_VERSION.tar.xz \
    "" "--with-gmp=$LOCAL_PREFIX" $LOCAL_PREFIX/include/mpfr.h
  ;;
*) echo "MPFR_RULE NOTIMPL: $MPFR_RULE"
esac

case $MPC_RULE in
skip) ;;
source)
  download_make_install_local ftp://ftp.gnu.org/gnu/mpc/mpc-$MPC_VERSION.tar.gz \
    "" "--with-gmp=$LOCAL_PREFIX --with-mpfr=$LOCAL_PREFIX" $LOCAL_PREFIX/include/mpc.h
 ;;
*) echo "MPC_RULE NOTIMPL: $MPC_RULE"
esac


case $GCC_RULE in
skip) ;;
system)
  case $TARGET in
  Ubuntu*)
    if ! [ -x "$(command -v g++)" ]; then
      $SYSTEM_INSTALL_COMMAND gcc g++
    fi
    export CC=gcc
    export CXX=g++
    ;;
  *)
    echo "GCC_RULE/TARGET NOTIMPL: $GCC_RULE/$TARGET"
  esac
  ;;
source) 
  install_gcc $LOCAL_PREFIX $LOCAL_PREFIX/bin/gcc 
  export CC=$LOCAL_PREFIX/bin/gcc
  export CXX=$LOCAL_PREFIX/bin/g++
  ;;
*) echo "GCC_RULE NOTIMPL: $GCC_RULE"
esac


case $EXPAT_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "EXPAT_RULE/TARGET NOTIMPL: $EXPAT_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/expat-$EXPAT_VERSION.tar.bz2 \
    "" "" $LOCAL_PREFIX/include/expat.h
  EXPAT_PREFIX=$LOCAL_PREFIX
  ;;
*) echo "EXPAT_RULE NOTIMPL: $EXPAT_RULE"
esac


case $ZLIB_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "ZLIB_RULE/TARGET NOTIMPL: $ZLIB_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/zlib-$ZLIB_VERSION.tar.xz \
  "" "" $LOCAL_PREFIX/include/zlib.h
  ;;
*) echo "ZLIB_RULE NOTIMPL: $ZLIB_RULE"
esac

case $LIBPNG_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LIBPNG_RULE/TARGET NOTIMPL: $LIBPNG_RULE/$TARGET"
  esac
  ;;
source)
  LIBPNG_VERSION=1.6.21
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/libpng-$LIBPNG_VERSION.tar.xz \
    "" "" $LOCAL_PREFIX/include/libpng16/png.h
  ;;
*) echo "LIBPNG_RULE NOTIMPL: $LIBPNG_RULE"
esac

case $BZIP2_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "BZIP2_RULE/TARGET NOTIMPL: $BZIP2_RULE/$TARGET"
  esac
  ;;
source)
  install_bzip2 $LOCAL_PREFIX $LOCAL_PREFIX/include/bzlib.h
  ;;
*) echo "BZIP2_RULE NOTIMPL: $BZIP2_RULE"
esac

case $XZ_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "XZ_RULE/TARGET NOTIMPL: $XZ_RULE/$TARGET"
  esac
  ;;
source)
  XZ_VERSION=5.2.3
  download_make_install_local https://tukaani.org/xz/xz-$XZ_VERSION.tar.gz \
    "" "" $LOCAL_PREFIX/include/lzma.h
  ;;
*) echo "XZ_RULE NOTIMPL: $XZ_RULE"
esac

#http://download.icu-project.org/files/icu4c/61.1/icu4c-61_1-src.tgz

case $ICU_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "ICU_RULE/TARGET NOTIMPL: $ICU_RULE/$TARGET"
  esac
  ;;
source)
  ICU_VERSION=61.1
  download_make_install_local http://download.icu-project.org/files/icu4c/61.1/icu4c-61_1-src.tgz \
    "icu/source" "" $LOCAL_PREFIX/include/unicode/ucnv.h
  ;;
*) echo "ICU_RULE NOTIMPL: $ICU_RULE"
esac


case $LIBXML2_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LIBXML2_RULE/TARGET NOTIMPL: $LIBXML2_RULE/$TARGET"
  esac
  ;;
source)
  LIBXML2_VERSION=2.9.7
  download_make_install_local http://xmlsoft.org/sources/libxml2-sources-$LIBXML2_VERSION.tar.gz \
    "libxml2-$LIBXML2_VERSION" "--with-lzma=$LOCAL_PREFIX --with-zlib=$LOCAL_PREFIX" \
     $LOCAL_PREFIX/include/libxml2/libxml/xmlversion.h
  ;;
*) echo "LIBXML2_RULE NOTIMPL: $LIBXML2_RULE"
esac


case $OPENSSL_RULE in
skip) ;;
system)
  case $TARGET in
  Ubuntu*)
    if ! [ -x "$(command -v openssl)" ]; then
      $SYSTEM_INSTALL_COMMAND openssl
    fi
    OPENSSL_PREFIX=$SYSTEM_PREFIX
    ;;
  *)
    echo "OPENSSL_RULE/TARGET NOTIMPL: $OPENSSL_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://www.openssl.org/source/openssl-$OPENSSL_VERSION.tar.gz \
      "" "linux-$(uname -m) no-shared no-dso -fPIC" $LOCAL_PREFIX/include/openssl/evp.h
  OPENSSL_PREFIX=$LOCAL_PREFIX
  ;;
*) echo "OPENSSL_RULE NOTIMPL: $OPENSSL_RULE"
esac

case $LIBARCHIVE_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LIBARCHIVE_RULE/TARGET NOTIMPL: $LIBARCHIVE_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local http://libarchive.org/downloads/libarchive-$LIBARCHIVE_VERSION.tar.gz \
    "" "--with-openssl=$OPENSSL_PREFIX" $LOCAL_PREFIX/include/archive.h
    #"" "--with-openssl=$OPENSSL_PREFIX --without-bz2lib" $LOCAL_PREFIX/include/archive.h
  ;;
*) echo "LIBARCHIVE_RULE NOTIMPL: $LIBARCHIVE_RULE"
esac


case $CURL_RULE in
skip) ;;
system)
  case $TARGET in
  Ubuntu*)
    if ! [ -x "$(command -v curl)" ]; then
      $SYSTEM_INSTALL_COMMAND curl
    fi
    ;;
  *)
    echo "CURL_RULE/TARGET NOTIMPL: $CURL_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/curl-$CURL_VERSION.tar.bz2 \
      "" "--disable-ldap --disable-ldaps --with-ssl=$OPENSSL_PREFIX --enable-http" \
      $LOCAL_PREFIX/include/curl/curl.h
  ;;
*) echo "CURL_RULE NOTIMPL: $CURL_RULE"
esac

case $CMAKE_RULE in
skip) ;;
system)
  case $TARGET in
  Ubuntu*)
    if ! [ -x "$(command -v cmake)" ]; then
      $SYSTEM_INSTALL_COMMAND cmake
    fi
    export CMAKE=cmake
    ;;
  *)
    echo "CMAKE_RULE/TARGET NOTIMPL: $CMAKE_RULE/$TARGET"
  esac
  ;;
source)
  CMAKE_VERSION=3.11.3
  download_make_install_local https://cmake.org/files/LatestRelease/cmake-$CMAKE_VERSION.tar.gz \
    "" "--parallel=$(nproc) --no-system-libs --system-curl" \
    $LOCAL_PREFIX/bin/cmake
  export CMAKE=$LOCAL_PREFIX/bin/cmake
  ;;
*) echo "CMAKE_RULE NOTIMPL: $CMAKE_RULE"
esac

case $BOOST_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "BOOST_RULE/TARGET NOTIMPL: $BOOST_RULE/$TARGET"
  esac
  ;;
source)
  install_boost $LOCAL_PREFIX $LOCAL_PREFIX/include/boost/version.hpp
  BOOST_PREFIX=$LOCAL_PREFIX
  BOOST_LIBDIR=$BOOST_PREFIX/lib
  ;;
*) echo "BOOST_RULE NOTIMPL: $BOOST_RULE"
esac

case $LIBEVENT_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LIBEVENT_RULE/TARGET NOTIMPL: $LIBEVENT_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://github.com/libevent/libevent/releases/download/release-$LIBEVENT_VERSION-stable/libevent-$LIBEVENT_VERSION-stable.tar.gz \
    "" "" $LOCAL_PREFIX/include/event2/event.h
  ;;
*) echo "LIBEVENT_RULE NOTIMPL: $LIBEVENT_RULE"
esac

case $BISONPP_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "BISONPP_RULE/TARGET NOTIMPL: $BISONPP_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://internal-dependencies.mapd.com/thirdparty/bisonpp-$BISONPP_VERSION-45.tar.gz \
    bison++-$BISONPP_VERSION "" $LOCAL_PREFIX/bin/bison++
  ;;
*) echo "BISONPP_RULE NOTIMPL: $BISONPP_RULE"
esac


case $DOUBLE_CONVERSION_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "DOUBLE_CONVERSION_RULE/TARGET NOTIMPL: $DOUBLE_CONVERSION_RULE/$TARGET"
  esac
  ;;
source)
  install_double_conversion $LOCAL_PREFIX $LOCAL_PREFIX/include/double-conversion/double-conversion.h
  ;;
*) echo "DOUBLE_CONVERSION_RULE NOTIMPL: $DOUBLE_CONVERSION_RULE"
esac

case $GFLAGS_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "GFLAGS_RULE/TARGET NOTIMPL: $GFLAGS_RULE/$TARGET"
  esac
  ;;
source)
  install_gflags $LOCAL_PREFIX $LOCAL_PREFIX/include/gflags/gflags.h
  LIBGFLAGS_INCLUDE_DIR=$BUILD_PREFIX/include
  ;;
*) echo "GFLAGS_RULE NOTIMPL: $GLFAGS_RULE"
esac

case $GLOG_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "GLOG_RULE/TARGET NOTIMPL: $GLOG_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local https://github.com/google/glog/archive/v$GLOG_VERSION.tar.gz \
      glog-$GLOG_VERSION "" $LOCAL_PREFIX/include/glog/logging.h
  ;;
*) echo "GLOG_RULE NOTIMPL: $GLOG_RULE"
esac

case $FOLLY_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "FOLLY_RULE/TARGET NOTIMPL: $FOLLY_RULE/$TARGET"
  esac
  ;;
source)
  install_folly $LOCAL_PREFIX $LOCAL_PREFIX/include/folly/folly-config.h
  ;;
*) echo "FOLLY_RULE NOTIMPL: $FOLLY_RULE"
esac

case $LIBKML_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LIBKML_RULE/TARGET NOTIMPL: $KML_RULE/$TARGET"
  esac
  ;;
source)
  install_libkml $LOCAL_PREFIX $LOCAL_PREFIX/include/kml/dom.h
  ;;
*) echo "LIBKML_RULE NOTIMPL: $LIBKML_RULE"
esac

case $PROJ_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "PROJ_RULE/TARGET NOTIMPL: $PROJ_RULE/$TARGET"
  esac
  ;;
source)
  download_make_install_local http://download.osgeo.org/proj/proj-$PROJ_VERSION.tar.gz \
    "" "" $LOCAL_PREFIX/include/proj_api.h
  ;;
*) echo "PROJ_RULE NOTIMPL: $PROJ_RULE"
esac

case $GDAL_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "GDAL_RULE/TARGET NOTIMPL: $GDAL_RULE/$TARGET"
  esac
  ;;
source)
    #"" "--without-curl --without-geos --with-libkml=$LOCAL_PREFIX --with-static-proj4=$LOCAL_PREFIX" \
  download_make_install_local http://download.osgeo.org/gdal/$GDAL_VERSION/gdal-$GDAL_VERSION.tar.xz \
    "" "--without-geos --with-libkml=$LOCAL_PREFIX --with-static-proj4=$LOCAL_PREFIX" \
    $LOCAL_PREFIX/include/gdal.h
  ;;
*) echo "GDAL_RULE NOTIMPL: $GDAL_RULE"
esac


case $THRIFT_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "THRIFT_RULE/TARGET NOTIMPL: $THRIFT_RULE/$TARGET"
  esac
  ;;
source)
  install_thrift $LOCAL_PREFIX $LOCAL_PREFIX/include/thrift/Thrift.h
  ;;
*) echo "THRIFT_RULE NOTIMPL: $THRIFT_RULE"
esac

case $NCURSES_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "NCURSES_RULE/TARGET NOTIMPL: $NCURSES_RULE/$TARGET"
  esac
  ;;
source)
  NCURSES_VERSION=6.1
  download_make_install_local ftp://ftp.gnu.org/pub/gnu/ncurses/ncurses-$NCURSES_VERSION.tar.gz \
    "" "" $LOCAL_PREFIX/include/ncurses/ncurses.h
  pushd $LOCAL_PREFIX/include
  ln -fs ncurses/curses.h curses.h
  popd
  ;;
*) echo "NCURSES_RULE NOTIMPL: $NCURSES_RULE"
esac

case $LIBEDIT_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LIBEDIT_RULE/TARGET NOTIMPL: $LIBEDIT_RULE/$TARGET"
  esac
  ;;
source)
  LIBEDIT_VERSION=20160903-3.1
  download_make_install_local http://thrysoee.dk/editline/libedit-$LIBEDIT_VERSION.tar.gz \
    "" "" $LOCAL_PREFIX/include/histedit.h
  ;;
*) echo "LIBEDIT_RULE NOTIMPL: $LIBEDIT_RULE"
esac


case $LLVM_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "LLVM_RULE/TARGET NOTIMPL: $LLVM_RULE/$TARGET"
  esac
  ;;
source)
  install_llvm $LOCAL_PREFIX $LOCAL_PREFIX/bin/clang
  ;;
*) echo "LLVM_RULE NOTIMPL: $LLVM_RULE"
esac


case $AWSCPP_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "AWSCPP_RULE/TARGET NOTIMPL: $AWSCPP_RULE/$TARGET"
  esac
  ;;
source)
  install_awscpp $LOCAL_PREFIX $LOCAL_PREFIX/include/aws/core/Aws.h
  ;;
*) echo "AWSCPP_RULE NOTIMPL: $AWSCPP_RULE"
esac

case $ARROW_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "ARROW_RULE/TARGET NOTIMPL: $ARROW_RULE/$TARGET"
  esac
  ;;
source)
  install_arrow $LOCAL_PREFIX $LOCAL_PREFIX/include/arrow/api.h
  ;;
*) echo "ARROW_RULE NOTIMPL: $ARROW_RULE"
esac


case $MAPDCORE_RULE in
skip) ;;
system)
  case $TARGET in
  *)
    echo "MAPDCORE_RULE/TARGET NOTIMPL: $MAPDCORE_RULE/$TARGET"
  esac
  ;;
source)
  install_mapdcore $LOCAL_PREFIX/mapd-core $LOCAL_PREFIX/mapd-core/bin/mapdql
  ;;
*) echo "MAPDCORE_RULE NOTIMPL: $MAPDCORE_RULE"
esac
