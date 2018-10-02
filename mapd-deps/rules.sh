GMP_RULE=skip
MPFR_RULE=skip
MPC_RULE=skip
GCC_RULE=skip  # using conda compiler, gcc-7

EXPAT_RULE=source
ZLIB_RULE=source
BZIP2_RULE=source
XZ_RULE=source
ICU_RULE=source
LIBXML2_RULE=source # requires xz, zlib, icu
OPENSSL_RULE=source
LIBARCHIVE_RULE=source # skipping, requires libxml2, openssl

CURL_RULE=source # requires openssl
CMAKE_RULE=source # requires curl, (expat, zlib, jsonpp, bzip2, lzma, libarchive)
SWIG_RULE=skip

BOOST_RULE=source
LIBEVENT_RULE=source
BISONPP_RULE=source

DOUBLE_CONVERSION_RULE=source
GFLAGS_RULE=source
GLOG_RULE=source
FOLLY_RULE=source # requires boost, openssl, gflags, glog, libevent

LIBKML_RULE=source # requires expat, zlib, boost, minizip>=1.2.8, googletest>=1.7.0
PROJ_RULE=source
GDAL_RULE=source # requires kml proj


THRIFT_RULE=source  # requires boost, ...
NCURSES_RULE=source
LIBEDIT_RULE=source
LLVM_RULE=source # requires ncurses, libedit, libxml2 ...

AWSCPP_RULE=source # requires ...
ARROW_RULE=source # requires ...

LIBPNG_RULE=source # requires zlib
MAPDCORE_RULE=skip #source # requires gdal, ... all the above
