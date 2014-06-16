#!/bin/sh
set -e

export NCPU=`nproc`

[ -d $BUILDDIR/gcc-bootstrap ] && rm -rf $BUILDDIR/gcc-bootstrap

mkdir -p $BUILDDIR/gcc-bootstrap
cd $BUILDDIR/gcc-bootstrap

PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-4.9.0/configure --build=$BUILDMACH --host=$BUILDMACH --target=$TARGETMACH --prefix=$INSTALLDIR --without-headers --enable-bootstrap --enable-languages=c --disable-threads --disable-libmudflap --with-gnu-ld --with-gnu-as --disable-libssp --disable-libgomp --disable-nls --disable-shared --program-prefix=${PROGRAM_PREFIX} --with-newlib --with-cpu=m2

make all-gcc -j${NCPU}
make install-gcc -j${NCPU}
make all-target-libgcc -j${NCPU}
make install-target-libgcc -j${NCPU}

cd $ROOTDIR
