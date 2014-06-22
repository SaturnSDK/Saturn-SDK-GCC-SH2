#!/bin/bash

echo "Extracting source files..."

if [ ! -d $SRCDIR ]; then
	mkdir -p $SRCDIR
fi

cd $SRCDIR

if [ ! -d binutils-${BINUTILSVER} ]; then
	tar xvjpf $DOWNLOADDIR/binutils-${BINUTILSVER}${BINUTILSREV}.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf binutils-${BINUTILSVER}
		exit 1
	fi
	cd $SRCDIR
fi

if [ ! -d gcc-${GCCVER} ]; then
	tar xvjpf $DOWNLOADDIR/gcc-${GCCVER}${GCCREV}.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf gcc-${GCCVER}
		exit 1
	fi
fi

if [ ! -d newlib-${NEWLIBVER} ]; then
	tar xvzpf $DOWNLOADDIR/newlib-${NEWLIBVER}${NEWLIBREV}.tar.gz
	if [ $? -ne 0 ]; then
		rm -rf newlib-${NEWLIBVER}
		exit 1
	fi
fi

if [ -z "${MPCVER}" ]; then
	printf ""
else
	if [ ! -d mpc-${MPCVER} ]; then
		tar xvpf $DOWNLOADDIR/mpc-${MPCVER}${MPCREV}.tar.gz
		if [ $? -ne 0 ]; then
			rm -rf mpc-${MPCVER}
			exit 1
		fi
		cp -rv mpc-${MPCVER} gcc-${GCCVER}/mpc
	fi
fi

if [ -z "${MPFRVER}" ]; then
	printf ""
else
	if [ ! -d mpfr-${MPFRVER} ]; then
		tar xvjpf $DOWNLOADDIR/mpfr-${MPFRVER}${MPFRREV}.tar.bz2
		if [ $? -ne 0 ]; then
			rm -rf mpfr-${MPFRVER}
			exit 1
		fi
		cp -rv mpfr-${MPFRVER} gcc-${GCCVER}/mpfr
	fi
fi

if [ -z "${GMPVER}" ]; then
	printf ""
else
	if [ ! -d gmp-${GMPVER} ]; then
		tar xvjpf $DOWNLOADDIR/gmp-${GMPVER}${GMPREV}.tar.bz2
		if [ $? -ne 0 ]; then
			rm -rf gmp-${GMPVER}
			exit 1
		fi
		cp -rv gmp-${GMPVER} gcc-${GCCVER}/gmp
	fi
fi

echo "Done"
