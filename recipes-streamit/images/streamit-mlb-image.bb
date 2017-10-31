DESCRIPTION = "Streamit MLB base image"

require recipes-rk/images/rk-image-multimedia.bb

GPTIMG_APPEND = "console=tty1 console=ttyS2,115200n8 rw root=/dev/mmcblk0p7 rootfstype=ext4 init=/sbin/init"

CORE_IMAGE_EXTRA_INSTALL += " \
	openssh \
    rsync \
    gdb \
    strace \
    valgrind \
    nano \
"
