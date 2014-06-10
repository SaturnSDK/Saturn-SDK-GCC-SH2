#!/bin/bash
set -e

export NCPU=`nproc`

[ -d $BUILDDIR/binutils ] && rm -rf $BUILDDIR/binutils

mkdir -p $BUILDDIR/binutils
cd $BUILDDIR/binutils

export CFLAGS="-fno-stack-protector -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0"

$SRCDIR/binutils-2.16.1/configure --disable-werror --host=$BUILDMACH --build=$BUILDMACH --target=$TARGETMACH --prefix=$INSTALLDIR --with-sysroot=$SYSROOTDIR --program-prefix=${PROGRAM_PREFIX} --disable-nls --enable-languages=c

make
#-j${NCPU}
make install -j${NCPU}

cd $ROOTDIR
