#!/bin/bash
# kernel build script by thehacker911

KERNEL_DIR=$(pwd)
BUILD_USER="$USER"
TOOLCHAIN_DIR=/home/thehacker911/android/toolchains
BUILD_JOB_NUMBER=`grep processor /proc/cpuinfo|wc -l`

# Toolchains

#Sabermod
#Linaro
BUILD_CROSS_COMPILE=$TOOLCHAIN_DIR/aarch64_linaro/bin/aarch64-linux-android-


#vars
KERNEL_DEFCONFIG=hacker_defconfig
BASE_VER="Hacker"
DEVICE_VER="-G920F"
VER="-V1"
HACKER_VER="$BASE_VER$DEVICE_VER$VER"


BUILD_KERNEL()
{	
	echo ""
	echo "=============================================="
	echo "START: MAKE CLEAN"
	echo "=============================================="
	echo ""
	

	make clean
	find . -name "*.dtb" -exec rm {} \;

	echo ""
	echo "=============================================="
	echo "END: MAKE CLEAN"
	echo "=============================================="
	echo ""

	echo ""
	echo "=============================================="
	echo "START: BUILD_KERNEL"
	echo "=============================================="
	echo ""
	echo "$HACKER_VER" 
	
	export LOCALVERSION=-`echo $HACKER_VER`
	export ARCH=arm64
	export CROSS_COMPILE=$BUILD_CROSS_COMPILE
	make ARCH=arm64 exynos7420-zeroflte_defconfig
	

	echo ""
	echo "================================="
	echo "END: BUILD_KERNEL"
	echo "================================="
	echo ""
}





# MAIN FUNCTION
rm -rf ./build.log
(
	START_TIME=`date +%s`
	BUILD_DATE=`date +%m-%d-%Y`
	BUILD_KERNEL


	END_TIME=`date +%s`
	let "ELAPSED_TIME=$END_TIME-$START_TIME"
	echo "Total compile time is $ELAPSED_TIME seconds"
) 2>&1	 | tee -a ./build.log

# Credits:
# Samsung
# google
# osm0sis
# cyanogenmod
# kylon 
