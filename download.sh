#!/bin/bash
if [ ! -d $DOWNLOADDIR ]; then
	mkdir -p $DOWNLOADDIR
fi

cd $DOWNLOADDIR

wget -c ftp://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2
wget -c ftp://ftp.gnu.org/gnu/gcc/gcc-4.9.0/gcc-4.9.0.tar.bz2
wget -c ftp://sourceware.org/pub/newlib/newlib-2.1.0.tar.gz
wget -c ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.2.tar.gz
wget -c ftp://ftp.gnu.org/gnu/mpfr/mpfr-3.1.2.tar.bz2
wget -c ftp://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2

cd $ROOTDIR

