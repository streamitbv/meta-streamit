inherit image_types streamit-mlb-img
IMAGE_TYPEDEP_streamit-mlb-emmc-img = "streamit-mlb-img"

EMMCIMG = "${IMAGE_BASENAME}-${MACHINE}-emmc.img"

IMAGE_CMD_streamit-mlb-emmc-img () {
	# Change to image directory
	cd ${DEPLOY_DIR_IMAGE}

	# Remove the existing image
	rm -f "${EMMCIMG}"

	# Burn Boot Partition
	dd if=${WORKDIR}/${EMMC_BOOT_IMG} of=${EMMCIMG} conv=notrunc,fsync

	# Burn Rootfs Partition
	dd if=${IMG_ROOTFS} of=${EMMCIMG} conv=notrunc,fsync seek=${BOOT_SIZE}
}
