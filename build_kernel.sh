#!/bin/bash

#Clone neutron-clang 
 mkdir toolchain && (cd toolchain; bash <(curl -s "https://raw.githubusercontent.com/Neutron-Toolchains/antman/main/antman") -S)
 
KERNEL_DEFCONFIG="veux_defconfig"
KERNEL_CMDLINE="ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- O=out LLVM=1"



#Building kernel
    export PATH=$(pwd)/toolchain/bin/:$PATH
    export ARCH=arm64
    export SUBARCH=arm64
    export DISABLE_WRAPPER=1
    make $KERNEL_CMDLINE $KERNEL_DEFCONFIG 
    make $KERNEL_CMDLINE -j$(nproc --all)

    
#Zip the kernel    
cp out/arch/arm64/boot/Image $(pwd)/AnyKernel3
cp out/arch/arm64/boot/dts/vendor/qcom/blair.dtb $(pwd)/AnyKernel3
cd AnyKernel3 && mv blair.dtb dtb && zip -r9 Rashoumon_veux_$(date +"%Y-%m-%d").zip *

echo "Done!"
