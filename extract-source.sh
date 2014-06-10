#!/bin/bash

if [ ! -d $SRCDIR ]; then
	mkdir -p $SRCDIR
fi

cd $SRCDIR

if [ ! -d binutils-2.16.1 ]; then
	tar xvjpf $DOWNLOADDIR/binutils-2.16.1a.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf binutils-2.16.1
		exit 1
	fi
	cd binutils-2.16.1/gprof
	patch -Np1 -i $ROOTDIR/patches/binutils/gprof-objc-fix.patch
	cd $SRCDIR
fi

if [ ! -d gcc-3.4.6 ]; then
	tar xvjpf $DOWNLOADDIR/gcc-3.4.6.tar.bz2
	if [ $? -ne 0 ]; then
		rm -rf gcc-3.4.6
		exit 1
	fi
	patch -Np1 -i $ROOTDIR/patches/gcc/collect2.c.patch
fi

if [ ! -d newlib-1.16.0 ]; then
	tar xvzpf $DOWNLOADDIR/newlib-1.16.0.tar.gz
	if [ $? -ne 0 ]; then
		rm -rf newlib-1.16.0
		exit 1
	fi
fi

cd $ROOTDIR
