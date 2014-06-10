#!/bin/sh
set -e

[ -d $BUILDIDR/gcc-bootstrap ] && rm -rf $BUILDDIR/gcc-bootstrap

mkdir -p $BUILDDIR/gcc-bootstrap
cd $BUILDDIR/gcc-bootstrap

PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-3.4.6/configure --build=$BUILDMACH --host=$BUILDMACH --target=$TARGETMACH --prefix=$INSTALLDIR --without-headers --enable-bootstrap --enable-languages=c --disable-threads --disable-libmudflap --with-gnu-ld --with-gnu-as --disable-libssp --disable-libgomp --disable-nls --disable-shared --program-prefix=${PROGRAM_PREFIX} --with-newlib

make all-gcc
make install-gcc

cd $ROOTDIR
