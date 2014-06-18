#!/bin/bash
set -e

export NCPU=`nproc`

[ -d $BUILDDIR/gcc-final ] && rm -rf $BUILDDIR/gcc-final

mkdir $BUILDDIR/gcc-final
cd $BUILDDIR/gcc-final

echo "libc_cv_forced_unwind=yes" > config.cache
echo "libc_ctors_header=yes" >> config.cache
echo "libc_cv_c_cleanup=yes" >> config.cache

export PATH=$INSTALLDIR/bin:$PATH

$SRCDIR/gcc-4.9.0/configure \
	--build=$BUILDMACH --target=$TARGETMACH --host=$HOSTMACH \
	--prefix=$INSTALLDIR --with-sysroot=$SYSROOTDIR --enable-languages=c \
	--with-gnu-as --with-gnu-ld --disable-shared --disable-threads \
	--disable-multilib --disable-libmudflap --disable-libssp --enable-lto \
	--disable-nls --with-mpfr-include=$SRCDIR/gcc-4.9.0/mpfr/src \
	--with-mpfr-lib=$(pwd)/mpfr/src/.libs --with-newlib \
	--program-prefix=${PROGRAM_PREFIX} --with-cpu=m2

make -j${NCPU}
make install -j${NCPU}

cd $ROOTDIR
