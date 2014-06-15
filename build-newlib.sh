#!/bin/sh
set -e

export NCPU=`nproc`

[ -d $BUILDDIR/newlib ] && rm -rf $BUILDDIR/newlib

mkdir -p $BUILDDIR/newlib
cd $BUILDDIR/newlib

export PATH=$INSTALLDIR/bin:$PATH
#export CROSS=${PROGRAM_PREFIX}
#export CC=${CROSS}gcc
#export LD=${CROSS}ld
#export AS=${CROSS}as

$SRCDIR/newlib-2.1.0/configure --prefix=$INSTALLDIR --target=$TARGETMACH --host=$BUILDMARCH

make all -j${NCPU}
make install -j${NCPU}

cd $ROOTDIR

