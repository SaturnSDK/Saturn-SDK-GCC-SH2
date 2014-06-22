#!/bin/bash
export BINUTILSVER=2.24
export BINUTILSREV=
export GCCVER=4.9.0
export GCCREV=
export NEWLIBVER=2.1.0
export NEWLIBREV=
export MPCVER=1.0.2
export MPCREV=
export MPFRVER=3.1.2
export MPFRREV=
export GMPVER=6.0.0
export GMPREV=a
export TARGETMACH=sh-elf
export PROGRAM_PREFIX=saturn-sh2-elf-
export GCC_BOOTSTRAP_FLAGS="--with-cpu=m2"
export GCC_FINAL_FLAGS="--with-cpu=m2 --with-sysroot=$SYSROOTDIR"

./build.sh
