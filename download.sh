#!/bin/bash
if [ ! -d $DOWNLOADDIR ]; then
	mkdir -p $DOWNLOADDIR
fi

cd $DOWNLOADDIR

if test "`curl -V`"; then
	FETCH="curl -f -L -O -C -"
elif test "`wget -V`"; then
	FETCH="wget -c"
else
	echo "Could not find either curl or wget, please install either one to continue"
	exit 1
fi

$FETCH ftp://ftp.gnu.org/gnu/gnu-keyring.gpg

$FETCH ftp://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2.sig
$FETCH ftp://ftp.gnu.org/gnu/gcc/gcc-4.9.0/gcc-4.9.0.tar.bz2.sig
$FETCH ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.2.tar.gz.sig
$FETCH ftp://ftp.gnu.org/gnu/mpfr/mpfr-3.1.2.tar.bz2.sig
$FETCH ftp://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2.sig

$FETCH ftp://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.bz2
$FETCH ftp://ftp.gnu.org/gnu/gcc/gcc-4.9.0/gcc-4.9.0.tar.bz2
$FETCH ftp://sourceware.org/pub/newlib/newlib-2.1.0.tar.gz
$FETCH ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.2.tar.gz
$FETCH ftp://ftp.gnu.org/gnu/mpfr/mpfr-3.1.2.tar.bz2
$FETCH ftp://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.bz2

# GPG return status
# 1 == bad signature
# 2 == no file
gpg --verify --keyring ./gnu-keyring.gpg binutils-2.24.tar.bz2.sig
if [ $? -ne 0 ]; then
	if [ $? -ne 0 ]; then
		echo "Failed to verify GPG signature for binutils"
		exit 1
	fi
fi

gpg --verify --keyring ./gnu-keyring.gpg gcc-4.9.0.tar.bz2.sig
if [ $? -ne 0 ]; then
	if [ $? -ne 0 ]; then
		echo "Failed to verify GPG signautre for gcc"
		exit 1
	fi
fi

gpg --verify --keyring ./gnu-keyring.gpg mpc-1.0.2.tar.gz.sig
if [ $? -ne 0 ]; then
	if [ $? -ne 0 ]; then
		echo "Failed to verify GPG signautre for mpc"
		exit 1
	fi
fi

gpg --verify --keyring ./gnu-keyring.gpg mpfr-3.1.2.tar.bz2.sig 
if [ $? -ne 0 ]; then
	if [ $? -ne 0 ]; then
		echo "Failed to verify GPG signautre for mpfr"
		exit 1
	fi
fi

