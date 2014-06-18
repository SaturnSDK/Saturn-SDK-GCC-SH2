#!/bin/bash

[ -d $INSTALLDIR ] && rm -rf $INSTALLDIR
[ -d ${INSTALLDIR}_host ] && rm -rf ${INSTALLDIR}_host

./download.sh

if [ $? -ne 0 ]; then
	echo "Failed to retrieve the files necessary for building GCC"
	exit 1
fi

./extract-sources.sh

# Build the cross compiler for the build
# Build the cross compiler for the target
export HOSTORIG=$HOSTMACH
export HOSTMACH=$BUILDMACH
export PREFIXORIG=$PROGRAM_PREFIX
export PROGRAM_PREFIX=sh-elf-
./build-binutils.sh
./build-gcc-bootstrap.sh
./build-newlib.sh
./build-gcc-final.sh
export PROGRAM_PREFIX=$PREFIXORIG

mv ${INSTALLDIR} ${INSTALLDIR}_host

export PATH=${INSTALLDIR}_host/bin:$PATH

# Build the cross compiler for the target using the host to build
export HOSTMACH=$HOSTORIG
./build-binutils.sh
./build-gcc-bootstrap.sh
export PROGRAM_PREFIX=sh-elf
./build-newlib.sh
export PROGRAM_PREFIX=$PREFIXORIG
./build-gcc-final.sh

