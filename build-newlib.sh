#!/bin/sh
set -e

export NCPU=`nproc`

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

$SRCDIR/newlib-2.1.0/configure --prefix=$INSTALLDIR --target=$TARGETMACH --host=$BUILDMARCH

make all -j${NCPU}
make install -j${NCPU}

cd $ROOTDIR

