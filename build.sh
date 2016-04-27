#!/bin/bash

if [[ "$HOSTMACH" != "$BUILDMACH" ]]; then
	echo "Build and host are not the same.  Building a Canadian-cross compiler"
	./build-canadian.sh
	exit $?
fi

if [ -z $NCPU ]; then
	# Mac OS X
	if $(command -v sysctl >/dev/null 2>&1); then
		export NCPU=`sysctl -n hw.ncpu`
	# coreutils
	elif $(command -v nproc >/dev/null 2>&1); then
		export NCPU=`nproc`
	# fallback to non-parallel build if we still have no idea
	else
		export NCPU=1
	fi
fi

[ -d $INSTALLDIR ] && rm -rf $INSTALLDIR

if [ -z $SKIP_DOWNLOAD]; then
	./download.sh

	if [ $? -ne 0 ]; then
		echo "Failed to retrieve the files necessary for building GCC"
		exit 1
	fi
fi

./extract-source.sh

if [ $? -ne 0 ]; then
	echo "Failed to extract the source files necessary for building GCC"
	exit 1
fi

./patch.sh

if [ $? -ne 0 ]; then
	echo "Failed to patch packages"
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

./build-libstdc++.sh

if [ $? -ne 0 ]; then
	echo "Failed building libstdc++"
	exit 1
fi

./build-gcc-final.sh

if [ $? -ne 0 ]; then
	echo "Failed building the final version of GCC"
	exit 1
fi

