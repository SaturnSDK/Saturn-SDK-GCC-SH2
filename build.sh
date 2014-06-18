#!/bin/bash

if [ -z NPROC ]; then
	export NCPU=`nproc`
fi

[ -d $INSTALLDIR ] && rm -rf $INSTALLDIR

./download.sh

if [ $? -ne 0 ]; then
	echo "Failed to retrieve the files necessary for building GCC"
	exit 1
fi

./extract-source.sh

if [ $? -ne 0 ]; then
	echo "Failed to extract the source files necessary for building GCC"
	exit 1
fi

./build-binutils.sh

if [ $? -ne 0 ]; then
	echo "Failed building binutils"
	exit 1
fi

./build-gcc-bootstrap.sh

if [ $? -ne 0 ]; then
	echo "Failed building the bootstrap phase of GCC"
	exit 1
fi

./build-newlib.sh

if [ $? -ne 0 ]; then
	echo "Failed building newlib"
	exit 1
fi

./build-gcc-final.sh

if [ $? -ne 0 ]; then
	echo "Failed building the final version of GCC"
	exit 1
fi

