#!/bin/sh
set -e

[ -d $BUILDDIR/libstdc++ ] && rm -rf $BUILDDIR/libstdc++

mkdir -p $BUILDDIR/libstdc++
cd $BUILDDIR/libstdc++

export PATH=$INSTALLDIR/bin:$PATH
export CROSS=${PROGRAM_PREFIX}
export CC=${CROSS}gcc
export CXX=${CROSS}g++
export CPP=${CROSS}cpp

$SRCDIR/gcc-${GCCVER}/libstdc++-v3/configure \
	--host=${TARGETMACH} --build=${BUILDMACH} --target=${TARGETMACH} --with-cross-host=${HOSTMACH} \
	--prefix=${INSTALLDIR} --disable-nls --disable-multilib --disable-libstdcxx-threads \
	--with-newlib --disable-libstdcxx-pch

make
#-j${NCPU}
make install -j${NCPU}

