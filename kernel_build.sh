#!/bin/bash

rm -rf out
mkdir out
export ARCH=arm64
export SUBARCH=arm64
export DTC_EXT=dtc

make O=out ARCH=arm64 pine_defconfig

PATH="${PWD}/bin:${PWD}/toolchain/bin:${PATH}" \
make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC=clang \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE=aarch64-linux-android- | tee kernel.log
