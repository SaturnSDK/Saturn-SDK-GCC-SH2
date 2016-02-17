#!/bin/bash

if [[ "$HOSTMACH" == "$BUILDMACH" ]]; then
	echo "Build and host are the same.  Building a cross compiler for one host/build architecture"
	./build.sh
	exit $?
fi

if [ -z $INSTALLDIR_BUILD_TARGET ]; then
	INSTALLDIR_BUILD_TARGET=${INSTALLDIR}_build_target
fi

if [ -z $NCPU ]; then
	export NCPU=`nproc`
fi

[ -d $INSTALLDIR ] && rm -rf $INSTALLDIR
[ -d ${INSTALLDIR_BUILD_TARGET} ] && rm -rf ${INSTALLDIR_BUILD_TARGET}

HOSTORIG=$HOSTMACH
PREFIXORIG=$PROGRAM_PREFIX

./download.sh

if [ $? -ne 0 ]; then
	echo "Failed to retrieve the files necessary for building GCC"
	exit 1
fi

./extract-source.sh

if [ $? -ne 0 ]; then
	echo "Failed to extract the source files"
	exit 1
fi

./patch.sh

if [ $? -ne 0 ]; then
	echo "Failed to patch packages"
	exit 1
fi

# Build the cross compiler for the build
# NOT IMPLEMENTED

# Build the cross compiler for the target
export HOSTMACH=$BUILDMACH
export PROGRAM_PREFIX=${TARGETMACH}-
CURRENT_COMPILER="${TARGETMACH} running on ${HOSTMACH}"
#export PROGRAM_PREFIX=${PREFIXORIG}

./build-binutils.sh
if [ $? -ne 0 ]; then
	echo "Failed to build binutils for ${CURRENT_COMPILER}"
	exit 1
fi

./build-gcc-bootstrap.sh
if [ $? -ne 0 ]; then
	echo "Failed to build GCC bootstrap for ${CURRENT_COMPILER}"
	exit 1
fi

./build-newlib.sh
if [ $? -ne 0 ]; then
	echo "Failed to build newlib for ${CURRENT_COMPILER}"
	exit 1
fi

./build-gcc-final.sh

if [ $? -ne 0 ]; then
	echo "Failed to build final GCC for ${CURRENT_COMPILER}"
	exit 1
fi
export PROGRAM_PREFIX=$PREFIXORIG

mv ${INSTALLDIR} ${INSTALLDIR_BUILD_TARGET}

export PATH=${INSTALLDIR_BUILD_TARGET}/bin:$PATH

# Build the cross compiler for the target using the host to build
export HOSTMACH=$HOSTORIG

CURRENT_COMPILER="${TARGETMACH} running on ${HOSTMACH}"

./build-binutils.sh
if [ $? -ne 0 ]; then
	echo "Failed to build binutils for ${CURRENT_COMPILER}"
	exit 1
fi

./build-gcc-bootstrap.sh
if [ $? -ne 0 ]; then
	echo "Failed to build GCC bootstrap for ${CURRENT_COMPILER}"
	exit 1
fi

export PROGRAM_PREFIX=${TARGETMACH}-
./build-newlib.sh
if [ $? -ne 0 ]; then
	echo "Failed to build newlib for ${CURRENT_COMPILER}"
	exit 1
fi
export PROGRAM_PREFIX=$PREFIXORIG

./build-gcc-final.sh
if [ $? -ne 0 ]; then
	echo "Failed to build final GCC for ${CURRENT_COMPILER}"
	exit 1
else
	echo "Successfully built GCC for ${CURRENT_COMPILER}"
fi

