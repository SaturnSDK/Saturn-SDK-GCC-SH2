#!/bin/bash
set -e

[ -d $BUILDDIR/gcc-final ] && rm -rf $BUILDDIR/gcc-final

mkdir $BUILDDIR/gcc-final
cd $BUILDDIR/gcc-final

$SRCDIR/gcc-3.4.6/configure --prefix=$INSTALLDIR --target=$TARGETMACH --enable-languages=c --disable-shared --disable-threads --disable-multilib --disable-libmudflap --with-newlib --program-prefix=${PROGRAM_PREFIX}

make
make install

cd $ROOTDIR
