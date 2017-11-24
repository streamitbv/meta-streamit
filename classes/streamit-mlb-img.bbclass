# Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd
# Copyright (C) 2017 Trevor Woerner <twoerner@gmail.com>
# Released under the MIT license (see COPYING.MIT for the terms)

# Use an uncompressed ext4 by default as rootfs
IMG_ROOTFS_TYPE = "ext4"
IMG_ROOTFS = "${IMGDEPLOYDIR}/${IMAGE_BASENAME}-${MACHINE}.${IMG_ROOTFS_TYPE}"

# This image depends on the rootfs image
IMAGE_TYPEDEP_streamit-mlb-img = "${IMG_ROOTFS_TYPE}"

EMMC_BOOT_IMG = "${IMAGE_BASENAME}-${MACHINE}-emmc-boot.img"
SD_BOOT_IMG = "${IMAGE_BASENAME}-${MACHINE}-sd-boot.img"
EMMC_GPTIMG_APPEND ??= "console=tty1 console=ttyS2,115200n8 rw \
	root=/dev/mmcblk2p5 rootfstype=ext4 init=/sbin/init"
SD_GPTIMG_APPEND ??= "console=tty1 console=ttyS2,115200n8 rw \
	root=/dev/mmcblk0p2 rootfstype=ext4 init=/sbin/init"

IDBLOADER = "idbloader.img"

# Get From rk-binary loader
DDR_BIN = "ddr.bin"
LOADER_BIN = "loader.bin"
MINILOADER_BIN = "miniloader.bin"
ATF_BIN = "atf.bin"
UBOOT_IMG = "u-boot.img"
TRUST_IMG = "trust.img"

# default partitions [in Sectors]
# More info at http://rockchip.wikidot.com/partitions
LOADER1_SIZE = "8000"
RESERVED1_SIZE = "128"
RESERVED2_SIZE = "8192"
LOADER2_SIZE = "8192"
ATF_SIZE = "8192"
BOOT_SIZE = "229376"

# WORKROUND: miss recipeinfo
do_image_streamit_mlb_img[depends] += " \
	rk-binary-loader:do_populate_lic \
	virtual/bootloader:do_populate_lic"

do_image_streamit_mlb_img[depends] += " \
	parted-native:do_populate_sysroot \
	u-boot-mkimage-native:do_populate_sysroot \
	mtools-native:do_populate_sysroot \
	gptfdisk-native:do_populate_sysroot \
	dosfstools-native:do_populate_sysroot \
	rk-binary-native:do_populate_sysroot \
	rk-binary-loader:do_deploy \
	virtual/kernel:do_deploy \
	virtual/bootloader:do_deploy"

PER_CHIP_IMG_GENERATION_COMMAND_rk3036 = "generate_loader1_image"
PER_CHIP_IMG_GENERATION_COMMAND_rk3288 = "generate_loader1_image"
PER_CHIP_IMG_GENERATION_COMMAND_rk3328 = "generate_aarch64_loader_image"
PER_CHIP_IMG_GENERATION_COMMAND_rk3399 = "generate_aarch64_loader_image"

IMAGE_CMD_streamit-mlb-img () {
	# Change to image directory
	cd ${DEPLOY_DIR_IMAGE}

    create_boot_image "${EMMC_BOOT_IMG}" "${EMMC_GPTIMG_APPEND}"
    create_boot_image "${SD_BOOT_IMG}" "${SD_GPTIMG_APPEND}"
}

create_boot_image () {
    BOOT_IMG="$1";
    GPTIMG_APPEND="$2";
    echo "BOOT IMG: ${BOOT_IMG}"
    echo "GPT APPEND: ${GPTIMG_APPEND}"
    rm -f "${BOOT_IMG}"
    rm -f "${WORKDIR}/${BOOT_IMG}"
	# Create boot partition image
	BOOT_BLOCKS=114688

	mkfs.vfat -n "boot" -S 512 -C ${WORKDIR}/${BOOT_IMG} $BOOT_BLOCKS
	mcopy -i ${WORKDIR}/${BOOT_IMG} -s ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-${MACHINE}.bin ::${KERNEL_IMAGETYPE}

	DTS_FILE=""
	DTBPATTERN="${KERNEL_IMAGETYPE}((-\w+)+\.dtb)"
	for DFILES in ${DEPLOY_DIR_IMAGE}/*; do
		DFILES=${DFILES##*/}
		if echo "${DFILES}" | grep -P $DTBPATTERN ; then
			[ -n "${DTS_FILE}" ] && bberror "Found multiple DTB under deploy dir, Please delete the unnecessary one."
			DTS_FILE=${DFILES#*${KERNEL_IMAGETYPE}-}
		fi
	done

	mcopy -i ${WORKDIR}/${BOOT_IMG} -s ${DEPLOY_DIR_IMAGE}/${KERNEL_IMAGETYPE}-${DTS_FILE} ::${DTS_FILE}

	# Create extlinux config file
	cat >${WORKDIR}/extlinux.conf <<EOF
default yocto

label yocto
	kernel /${KERNEL_IMAGETYPE}
	devicetree /${DTS_FILE}
	append ${GPTIMG_APPEND}
EOF

	mmd -i ${WORKDIR}/${BOOT_IMG} ::/extlinux
	mcopy -i ${WORKDIR}/${BOOT_IMG} -s ${WORKDIR}/extlinux.conf ::/extlinux/

	cd ${DEPLOY_DIR_IMAGE}
	if [ -f ${WORKDIR}/${BOOT_IMG} ]; then
		cp ${WORKDIR}/${BOOT_IMG} ./
	fi
}
