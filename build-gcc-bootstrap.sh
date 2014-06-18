#!/bin/sh
set -e

[ -d $BUILDDIR/gcc-bootstrap ] && rm -rf $BUILDDIR/gcc-bootstrap

mkdir -p $BUILDDIR/gcc-bootstrap
cd $BUILDDIR/gcc-bootstrap

PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-4.9.0/configure \
	--build=$BUILDMACH --host=$HOSTMACH --target=$TARGETMACH \
	--prefix=$INSTALLDIR --without-headers --enable-bootstrap \
	--enable-languages=c --disable-threads --disable-libmudflap \
	--with-gnu-ld --with-gnu-as --with-gcc --disable-libssp --disable-libgomp \
	--disable-nls --disable-shared --program-prefix=${PROGRAM_PREFIX} \
	--with-newlib --with-cpu=m2 --enable-interwork --disable-win32-registry

make all-gcc -j${NCPU}
make install-gcc -j${NCPU}
make all-target-libgcc -j${NCPU}
make install-target-libgcc -j${NCPU}
