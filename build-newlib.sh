#!/bin/sh
set -e

[ -d $BUILDDIR/newlib ] && rm -rf $BUILDDIR/newlib

mkdir -p $BUILDDIR/newlib
cd $BUILDDIR/newlib

export PATH=$INSTALLDIR/bin:$PATH
export CROSS=${PROGRAM_PREFIX}
export CC_FOR_TARGET=${CROSS}gcc
export LD_FOR_TARGET=${CROSS}ld
export AS_FOR_TARGET=${CROSS}as
export AR_FOR_TARGET=${CROSS}ar
export RANLIB_FOR_TARGET=${CROSS}ranlib

$SRCDIR/newlib-${NEWLIBVER}/configure --prefix=$INSTALLDIR \
	--target=$TARGETMACH --build=$BUILDMACH --host=$HOSTMACH

make all -j${NCPU}
make install -j${NCPU}
