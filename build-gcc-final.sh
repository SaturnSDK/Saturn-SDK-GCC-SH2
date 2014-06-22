#!/bin/bash
set -e

[ -d $BUILDDIR/gcc-final ] && rm -rf $BUILDDIR/gcc-final

mkdir $BUILDDIR/gcc-final
cd $BUILDDIR/gcc-final

#echo "libc_cv_forced_unwind=yes" > config.cache
#echo "libc_ctors_header=yes" >> config.cache
#echo "libc_cv_c_cleanup=yes" >> config.cache

export PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-${GCCVER}/configure \
	--build=$BUILDMACH --target=$TARGETMACH --host=$HOSTMACH \
	--prefix=$INSTALLDIR --enable-languages=c \
	--with-gnu-as --with-gnu-ld --disable-shared --disable-threads \
	--disable-multilib --disable-libmudflap --disable-libssp --enable-lto \
	--disable-nls --with-newlib \
	--program-prefix=${PROGRAM_PREFIX} ${GCC_FINAL_FLAGS}

make -j${NCPU}
make install -j${NCPU}
