### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# begin properties
properties() { '
kernel.string=Rashoumon Kernel 1.0 by Cexary
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
supported.versions=
supported.patchlevels=
'; } # end properties

### AnyKernel install
override_cmdline() {
local cmdline='quiet console=ttyMSM0,115200n8 earlycon=msm_geni_serial,0x04C8C000 androidboot.hardware=qcom androidboot.console=ttyMSM0 androidboot.memcg=1 lpm_levels.sleep_disabled=1 video=vfb:640x400,bpp=32,memsize=3072000 msm _rtb.filter= 0x237 service_locator.enable=1 androidboot.usbcontroller=4e00000.dwc3 swiotlb=0 loop.max_part=7 cgroup.memory=nokmem,nosocket iptable_raw.raw_before_defrag=1 ip6table_raw.raw_before_defrag=1 firmware_class.path=/vendor/firmware'
sed -i '/^cmdline/d' $split_img/header;
echo cmdline=$cmdline >> $split_img/header;
}

## boot shell variables
block=boot;
is_slot_device=auto;
no_block_display=1;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;
ui_print " " "Flashing KernelSU version. You have been warned about security implications.";

# boot install
split_boot;
flash_boot;
## end boot install

## vendor_boot shell variables
block=vendor_boot;
is_slot_device=auto;

# reset for vendor_boot patching
reset_ak;

# vendor_boot install
split_boot;
override_cmdline;
flash_boot;
## end vendor_kernel_boot install
