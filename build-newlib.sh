#!/bin/sh
set -e

[ -d $BUILDDIR/newlib ] && rm -rf $BUILDDIR/newlib

mkdir -p $BUILDDIR/newlib
cd $BUILDDIR/newlib

export PATH=$INSTALLDIR/bin:$PATH
#export CROSS=saturn-
#export CC=${CROSS}gcc
#export LD=${CROSS}ld
#export AS=${CROSS}as

$SRCDIR/newlib-1.16.0/configure --prefix=$INSTALLDIR --target=$TARGETMACH --host=$BUILDMARCH --program-prefix=saturn- --with-gnu-as --with-gnu-ld

make all
make install

cd $ROOTDIR

