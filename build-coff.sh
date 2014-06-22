export BINUTILSVER=2.16.1
export BINUTILSREV=a
export GCCVER=4.4.7
export GCCREV=
export NEWLIBVER=1.16.0
export NEWLIBREV=
export TARGETMACH=sh-coff

export PROGRAM_PREFIX=saturn-sh2-coff-

export BINUTILS_CFLAGS="-fno-stack-protector -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0"
export GCC_BOOTSTRAP_FLAGS="--enable-obsolete --with-cpu=m2"
export GCC_FINAL_FLAGS="--enable-obsolete --with-cpu=m2 --with-sysroot=$SYSROOTDIR"

./build.sh
