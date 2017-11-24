inherit image_types streamit-mlb-img
IMAGE_TYPEDEP_streamit-mlb-sd-img = "streamit-mlb-img"

SDIMG = "${IMAGE_BASENAME}-${MACHINE}-sd.img"

IMAGE_CMD_streamit-mlb-sd-img () {
	# Change to image directory
	cd ${DEPLOY_DIR_IMAGE}

	# Remove the existing image
	rm -f "${SDIMG}"

	# last dd rootfs will extend gpt image to fit the size,
	# but this will overrite the backup table of GPT
	# will cause corruption error for GPT
	IMG_ROOTFS_SIZE=$(stat -L --format="%s" ${IMG_ROOTFS})

	SDIMG_MIN_SIZE=$(expr $IMG_ROOTFS_SIZE + \( ${BOOT_SIZE} + 35 \) \* 512 )

	SD_IMAGE_SIZE=$(expr $SDIMG_MIN_SIZE \/ 1024 \/ 1024 + 2)

	# Initialize sdcard image file
	dd if=/dev/zero of=${SDIMG} bs=1M count=0 seek=$SD_IMAGE_SIZE

	# Create partition table
	parted -s ${SDIMG} mklabel gpt

	# Create vendor defined partitions
	BOOT_START=64
	ROOTFS_START=$(expr ${BOOT_START} + ${BOOT_SIZE})

	# Create boot partition and mark it as bootable
	parted -s ${SDIMG} unit s mkpart boot ${BOOT_START} $(expr ${ROOTFS_START} - 1)
	parted -s ${SDIMG} set 1 boot on

	# Create rootfs partition
	parted -s ${SDIMG} -- unit s mkpart rootfs ${ROOTFS_START} -34s

	parted ${SDIMG} print

	# Burn Boot Partition
	dd if=${WORKDIR}/${SD_BOOT_IMG} of=${SDIMG} conv=notrunc,fsync seek=${BOOT_START}

	# Burn Rootfs Partition
	dd if=${IMG_ROOTFS} of=${SDIMG} conv=notrunc,fsync seek=${ROOTFS_START}
}
