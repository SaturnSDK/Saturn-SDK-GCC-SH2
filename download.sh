#!/bin/bash
if [ ! -d $DOWNLOADDIR ]; then
	mkdir -p $DOWNLOADDIR
fi

cd $DOWNLOADDIR

wget -c ftp://ftp.gnu.org/gnu/binutils/binutils-2.16.1a.tar.bz2
wget -c ftp://sourceware.org/pub/newlib/newlib-1.16.0.tar.gz
wget -c ftp://ftp.gnu.org/gnu/gcc/gcc-3.4.6/gcc-3.4.6.tar.bz2

cd $ROOTDIR

