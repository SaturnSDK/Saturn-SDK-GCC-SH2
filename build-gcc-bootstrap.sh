#!/bin/sh
set -e

[ -d $BUILDDIR/gcc-bootstrap ] && rm -rf $BUILDDIR/gcc-bootstrap

mkdir -p $BUILDDIR/gcc-bootstrap
cd $BUILDDIR/gcc-bootstrap

PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-${GCCVER}/configure \
	--build=$BUILDMACH --host=$HOSTMACH --target=$TARGETMACH \
	--prefix=$INSTALLDIR --without-headers --enable-bootstrap \
	--enable-languages=c --disable-threads --disable-libmudflap \
	--with-gnu-ld --with-gnu-as --with-gcc --disable-libssp --disable-libgomp \
	--disable-nls --disable-shared --program-prefix=${PROGRAM_PREFIX} \
	--with-newlib --disable-multilib \
	${GCC_BOOTSTRAP_FLAGS}

make all-gcc -j${NCPU}
make install-gcc -j${NCPU}

#make all-target-libgcc -j${NCPU}
#make install-target-libgcc -j${NCPU}
