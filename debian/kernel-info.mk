# SPDX-License-Identifier: GPL-2.0
# Example kernel-info.mk for Droidian packaging
# EDIT THIS FILE with your device-specific values
# Values marked [CEK] MUST be obtained from stock boot.img (unpackbootimg) and device (getprop)

# Kernel version (from Makefile VERSION.PATCHLEVEL.SUBLEVEL)
# localversion-cip + localversion-st suffixes are handled automatically
KERNEL_BASE_VERSION = 4.19.325

# Defconfig name (without _defconfig suffix)
KERNEL_DEFCONFIG = gale_defconfig

# Architecture
KERNEL_ARCH = arm64
DEB_BUILD_FOR = arm64

# Kernel image type
# Image.gz = gzipped Image with DTB appended after (default for Android 9+)
# Image.gz-dtb = legacy, DTB appended to kernel
# Image = uncompressed, prebuilt DT
KERNEL_IMAGE_TARGET = Image.gz

# DTB handling
KERNEL_IMAGE_WITH_DTB = 1
KERNEL_IMAGE_DTB = arch/arm64/boot/dts/mediatek/mt6768.dtb

# DTBO (overlay) handling
KERNEL_IMAGE_WITH_DTB_OVERLAY = 1
KERNEL_IMAGE_DTB_OVERLAY = arch/arm64/boot/dts/mediatek/gale.dtbo

# Prebuilt DT (only for Samsung devices typically)
# KERNEL_PREBUILT_DT =

# Boot image parameters - OBTAINED FROM unpack_bootimg ON STOCK BOOT.IMG
# unpack_bootimg --boot_img boot.img
# Output from boot.img:
#   boot magic: ANDROID!
#   kernel_size: 18977253
#   ramdisk size: 17283808
#   kernel load address: 0x40080000
#   ramdisk load address: 0x47c80000
#   second bootloader size: 0
#   kernel tags load address: 0x4bc80000
#   page size: 2048
#   os version: 17.0.0 (Android 13)
#   os patch level: 2026-09
#   boot image header version: 2
#   command line args: bootopt=64S3,32N2,64N2 androidboot.init_fatal_reboot_target=recovery
#   dtb size: 127664
#   dtb address: 0x0000000041f78000

KERNEL_BOOTIMAGE_CMDLINE = bootopt=64S3,32N2,64N2 androidboot.init_fatal_reboot_target=recovery console=tty0 droidian.lvm.prefer
# REMOVE any 'systempart=' entry from stock cmdline!
# If stock has 'console=ttyMT3,921600n1', REPLACE with 'console=tty0' (Halium requirement)

KERNEL_BOOTIMAGE_PAGE_SIZE = 2048
KERNEL_BOOTIMAGE_BASE_OFFSET = 0x40078000
KERNEL_BOOTIMAGE_KERNEL_OFFSET = 0x00008000
KERNEL_BOOTIMAGE_INITRAMFS_OFFSET = 0x11a88000
KERNEL_BOOTIMAGE_SECONDIMAGE_OFFSET = 0x00000000
KERNEL_BOOTIMAGE_TAGS_OFFSET = 0x07808000
KERNEL_BOOTIMAGE_DTB_OFFSET = 0x01f78000
# Header version from unpack_bootimg (Android 8- =0, 9=1, 10/11=2, GKI=3)
# Android 13 non-GKI header version = 2
KERNEL_BOOTIMAGE_VERSION = 2

# Device identification (used for package naming)
DEVICE_VENDOR := xiaomi
DEVICE_MODEL := gale
DEVICE_FULL_NAME := Redmi 13C / POCO C65

# Vendor info for flash-bootimage
FLASH_ENABLED = 1
# A/B device (Redmi 13C/POCO C65) - verified: getprop ro.build.ab_update = true
FLASH_IS_LEGACY_DEVICE = 0
# OBTAIN FROM DEVICE: sudo android_getprop ro.product.vendor.manufacturer [CEK]
FLASH_INFO_MANUFACTURER = Xiaomi
# OBTAIN FROM DEVICE: sudo android_getprop ro.product.vendor.model [CEK] = 23108RN04Y
# Using marketing name for readability; internal code = 23108RN04Y
FLASH_INFO_MODEL = Redmi 13C
# OBTAIN FROM DEVICE: cat /proc/cpuinfo | grep -i hardware [CEK]
FLASH_INFO_CPU = MT6768

# Toolchain - manual Linaro GCC 6.3.1 in /opt (matches build.config.mtk.aarch64.gcc)
# + Debian cross gcc-aarch64 as fallback in /usr/bin
# /opt/ccache-wrap shadows the cross-gcc with a ccache wrapper (same compiler).
# Persist cache via podman: -v $PWD/CCACHE-DIR:/buildd/ccache:Z -e CCACHE_DIR=/buildd/ccache
CLANG_CUSTOM := 0
DEB_TOOLCHAIN := gcc
BUILD_PATH := /opt/ccache-wrap:/opt/gcc-6.3.1/bin:/usr/bin
BUILD_CC := aarch64-linux-gnu-gcc
# BUILD_CLANG_TRIPLET not needed for GCC
BUILD_CLANG_TRIPLET := aarch64-linux-gnu

# Use config fragments from droidian/ folder
KERNEL_CONFIG_USE_FRAGMENTS = 1
# Optional: use diffconfig to compare fragments vs defconfig
# KERNEL_CONFIG_USE_DIFFCONFIG = 1
# KERNEL_PRODUCT_DIFFCONFIG = diffconfig

# Samsung only
# DEVICE_VBMETA_IS_SAMSUNG = 0