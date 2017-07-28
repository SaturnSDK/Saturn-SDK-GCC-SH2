#!/bin/bash

function print_environment_variable_usage
{
        PRINT_USAGE="ALL"
        if [ -n "$1" ]; then
                PRINT_USAGE="$1"
        fi

        printf "\nEnvironment variable usage\n"
        printf "%s\n\n" "--------------------------"

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "ROOTDIR" ]; then
                printf "ROOTDIR        - The directory for the root of the build process\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "DOWNLOADDIR" ]; then
                printf "DOWNLOADDIR    - The directory that contains the various required archive\n"
                printf "                 packages\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "SRCDIR" ]; then
                printf "SRCDIR         - The directory that contains the extracted source files for\n"
                printf "                 each program used in the build process.\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "BUILDDIR" ]; then
                printf "BUILDDIR       - The directory that contains the built program files\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "INSTALLDIR" ]; then
                printf "INSTALLDIR     - The directory that contains all of the built program files\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "SYSROOTDIR" ]; then
                printf "SYSROOTDIR     - The directory where the sysroot directory lives (typically,\n"
                printf "                 this should be set to \${INSTALLDIR}/sysroot)\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "TARGETMACH" ]; then
                printf "TARGETMACH     - The architecture that the compiler is targetting\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "BUILDMACH" ]; then
                printf "BUILDMACH      - The current machine's architecture for building the programs\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "HOSTMACH" ]; then
                printf "HOSTMACH       - The architecture that the programs will run on\n"
        fi

        if [ "${PRINT_USAGE}" == "ALL" ] || [ "${PRINT_USAGE}" == "PROGRAM_PREFIX" ]; then
                printf "PROGRAM_PREFIX - The prefix used before the tool's name, such as:\n"
                printf "                 saturn-sh2-gcc, where gcc is the program, with saturn-sh2-\n"
                printf "                 being the prefix\n"
        fi
}

if [ -z ${ROOTDIR} ]; then
	printf "The environment variable \${ROOTDIR} was not set\n"
	print_environment_variable_usage "ROOTDIR"
	exit -1
fi

if [ -z ${DOWNLOADDIR} ]; then
	printf "The environment variable \${DOWNLOADDIR} was not set\n"
	print_environment_variable_usage "DOWNLOADDIR"
	exit -1
fi

if [ -z ${SRCDIR} ]; then
	printf "The environment variable \${SRCDIR} was not set\n"
	print_environment_variable_usage "SRCDIR"
	exit -1
fi

if [ -z ${BUILDDIR} ]; then
	printf "The environment variable \${BUILDDIR} was not set\n"
	print_environment_variable_usage "BUILDDIR"
	exit -1
fi

if [ -z ${INSTALLDIR} ]; then
	printf "The environment variable \${INSTALLDIR} was not set\n"
	print_environment_variable_usage "INSTALLDIR"
	exit -1
fi

if [ -z ${SYSROOTDIR} ]; then
	printf "The environment variable \${SYSROOTDIR} was not set\n"
	print_environment_variable_usage "SYSROOTDIR"
	exit -1
fi

if [ -z ${TARGETMACH} ]; then
	printf "The environment variable \${TARGETMACH} was not set\n"
	print_environment_variable_usage "TARGETMACH"
	exit -1
fi

if [ -z ${BUILDMACH} ]; then
	printf "The environment variable \${BUILDMACH} was not set\n"
	print_environment_variable_usage "BUILDMACH"
	exit -1
fi

if [ -z ${HOSTMACH} ]; then
	printf "The environment variable \${HOSTMACH} was not set\n"
	print_environment_variable_usage "HOSTMACH"
	exit -1
fi

if [ -z ${PROGRAM_PREFIX} ]; then
	printf "The environment variable \${PROGRAM_PREFIX} was not set\n"
	print_environment_variable_usage "PROGRAM_PREFIX"
	exit -1
fi

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

