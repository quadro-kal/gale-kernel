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
# Non-A/B device (Redmi 13C/POCO C65) - check: getprop ro.build.ab_update [CEK]
FLASH_IS_LEGACY_DEVICE = 1
# OBTAIN FROM DEVICE: sudo android_getprop ro.product.vendor.manufacturer [CEK]
FLASH_INFO_MANUFACTURER = Xiaomi
# OBTAIN FROM DEVICE: sudo android_getprop ro.product.vendor.model [CEK]
FLASH_INFO_MODEL = Redmi 13C
# OBTAIN FROM DEVICE: cat /proc/cpuinfo | grep -i hardware [CEK]
FLASH_INFO_CPU = MT6768

# Toolchain - Droidian provides clang-android-14.0-r450784d for Android 13
# Fallback order: clang-android-14.0-r450784d -> clang-android-12.0-r416183b -> manual clang-r433403b -> GCC 4.9
# Set CLANG_CUSTOM=1 to use exact DEB_TOOLCHAIN value (otherwise kernel-snippet.mk prepends clang-android-$(CLANG_VERSION), )
CLANG_CUSTOM := 1
DEB_TOOLCHAIN := clang-android-14.0-r450784d
BUILD_PATH := /usr/lib/llvm-android-14.0-r450784d/bin
BUILD_CC := clang

# Use config fragments from droidian/ folder
KERNEL_CONFIG_USE_FRAGMENTS = 1
# Optional: use diffconfig to compare fragments vs defconfig
# KERNEL_CONFIG_USE_DIFFCONFIG = 1
# KERNEL_PRODUCT_DIFFCONFIG = diffconfig

# Samsung only
# DEVICE_VBMETA_IS_SAMSUNG = 0