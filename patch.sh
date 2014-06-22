#!/bin/bash

if [ -d $ROOTDIR/patches/binutils/${BINUTILSVER}${BINUTILSREV} ]; then
	cd $SRCDIR
	for file in $ROOTDIR/patches/binutils/${BINUTILSVER}${BINUTILSREV}/*.patch; do
		patch -Np1 -i $file
		if [ $? -eq 0 ]; then
			echo "Patched ${file}"
		elif [ $? -eq 1 ]; then
			echo "Already applied patch ${file}"
		else
			echo "Failed to apply patch ${file}"
			exit 1
		fi
	done
fi

if [ -d $ROOTDIR/patches/gcc/${GCCVER}${GCCREV} ]; then
	cd $SRCDIR
	for file in $ROOTDIR/patches/gcc/${GCCVER}${GCCREV}/*.patch; do
		patch -Np1 -i $file
		if [ $? -eq 0 ]; then
			echo "Patched ${file}"
		elif [ $? -eq 1 ]; then
			echo "Already applied patch ${file}"
		else
			echo "Failed to apply patch ${file}"
			exit 1
		fi
	done
fi

exit 0
