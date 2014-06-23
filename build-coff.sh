#!/bin/bash
export BINUTILSVER=2.16.1
export BINUTILSREV=a
export GCCVER=4.4.7
export GCCREV=
export NEWLIBVER=1.16.0
export NEWLIBREV=
export MPFRVER=2.4.2
export MPFRREV=
export GMPVER=5.1.0
export GMPREV=a

export OBJFORMAT=COFF

export TARGETMACH=sh-coff

if [ -z ${PROGRAM_PREFIX} ]; then
	export PROGRAM_PREFIX=saturn-sh2-coff-
else
	export PROGRAM_PREFIX=${PROGRAM_PREFIX}coff-
fi

export BINUTILS_CFLAGS="-fno-stack-protector -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0"
export GCC_BOOTSTRAP_FLAGS="--enable-obsolete --with-cpu=m2"
export GCC_FINAL_FLAGS="--enable-obsolete --with-cpu=m2 --with-sysroot=$SYSROOTDIR"

export INSTALLDIR=${INSTALLDIR}_coff

./build.sh

if [[ "${CREATEINSTALLER}" == "YES" ]]; then
	./createinstaller.sh
fi
