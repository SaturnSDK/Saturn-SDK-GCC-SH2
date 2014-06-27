#!/bin/sh
set -e

[ -d $BUILDDIR/gcc-bootstrap ] && rm -rf $BUILDDIR/gcc-bootstrap

mkdir -p $BUILDDIR/gcc-bootstrap
cd $BUILDDIR/gcc-bootstrap

export PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-${GCCVER}/configure \
	--build=$BUILDMACH --host=$HOSTMACH --target=$TARGETMACH \
	--prefix=$INSTALLDIR --without-headers --enable-bootstrap \
	--enable-languages=c --disable-threads --disable-libmudflap \
	--with-gnu-ld --with-gnu-as --with-gcc --disable-libssp --disable-libgomp \
	--disable-nls --disable-shared --program-prefix=${PROGRAM_PREFIX} \
	--with-newlib --disable-multilib --disable-libgcj \
	--without-included-gettext \
	${GCC_BOOTSTRAP_FLAGS}

#if [[ "${HOSTMACH}" != "${BUILDMACH}" ]]; then
#	# There should be a check for if gcc/auto-build.h exists
#	cp ./gcc/auto-host.h ./gcc/auto-build.h
#	mkdir gcc
#	cp $ROOTDIR/auto-host.h ./gcc/auto-build.h
#fi

make all-gcc -j${NCPU}
make install-gcc -j${NCPU}

make all-target-libgcc -j${NCPU}
make install-target-libgcc -j${NCPU}
