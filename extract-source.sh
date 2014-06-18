#!/bin/bash

echo "Extracting source files..."

if [ ! -d $SRCDIR ]; then
	mkdir -p $SRCDIR
fi

cd $SRCDIR

if [ ! -d binutils-2.24 ]; then
	tar xvjpf $DOWNLOADDIR/binutils-2.24.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf binutils-2.24
		exit 1
	fi
	cd $SRCDIR
fi

if [ ! -d gcc-4.9.0 ]; then
	tar xvjpf $DOWNLOADDIR/gcc-4.9.0.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf gcc-4.9.0
		exit 1
	fi
fi

if [ ! -d newlib-2.1.0 ]; then
	tar xvzpf $DOWNLOADDIR/newlib-2.1.0.tar.gz
	if [ $? -ne 0 ]; then
		rm -rf newlib-2.1.0
		exit 1
	fi
fi

if [ ! -d mpc-1.0.2 ]; then
	tar xvpf $DOWNLOADDIR/mpc-1.0.2.tar.gz
	if [ $? -ne 0 ]; then
		rm -rf mpc-1.0.2
		exit 1
	fi
	cp -rv mpc-1.0.2 gcc-4.9.0/mpc
fi

if [ ! -d mpfr-3.1.2 ]; then
	tar xvjpf $DOWNLOADDIR/mpfr-3.1.2.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf mpfr-3.1.2
		exit 1
	fi
	cp -rv mpfr-3.1.2 gcc-4.9.0/mpfr
fi

if [ ! -d gmp-6.0.0 ]; then
	tar xvjpf $DOWNLOADDIR/gmp-6.0.0a.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf gmp-6.0.0
		exit 1
	fi
	cp -rv gmp-6.0.0 gcc-4.9.0/gmp
fi

echo "Done"
