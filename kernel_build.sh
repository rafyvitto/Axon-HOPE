#!/bin/bash
# Bash Color
green='\033[01;32m'
red='\033[01;31m'
blink_red='\033[05;31m'
restore='\033[0m'

rm -rf out
mkdir out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc

echo -e "${green}"
echo "---------------------------------------"
echo "Finding defconfig,setting up Toolchain:"
echo "---------------------------------------"
echo -e "${restore}" 

make O=out ARCH=arm64 pine_defconfig

PATH="${PWD}/bin:${PWD}/toolchain/bin:${PATH}" \

DATE_START=$(date +"%s")


echo -e "${green}"
echo "-----------------"
echo "Building Kernel:"
echo "-----------------"
echo -e "${restore}" 

make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- | tee kernel.log
                       


echo -e "${green}"
echo "-------------------"
echo "Build Completed in:"
echo "-------------------"
echo -e "${restore}"

DATE_END=$(date +"%s")
DIFF=$(($DATE_END - $DATE_START))
echo "Time: $(($DIFF / 60)) minute(s) and $(($DIFF % 60)) seconds."
echo                   
