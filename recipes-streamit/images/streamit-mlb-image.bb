DESCRIPTION = "Streamit MLB base image"

require recipes-rk/images/rk-image-multimedia.bb

inherit extrausers

EXTRA_USERS_PARAMS ?= " \
    useradd -p '\$6\$WTl6/ng22ijfBklW\$a3jrDgN3d8uLMtyCifKG33PNo0/K5L1Je.ulHEtxZzjSNFUsX.GPYQcYA7IzRGh5CAu82l3QjiRSwaxGCKctY0' -s '/bin/bash' waveuser; \
    usermod -aG sudo waveuser; \
    usermod -p '!' root; \
"

GPTIMG_APPEND = "console=tty1 console=ttyS2,115200n8 rw root=/dev/mmcblk0p7 rootfstype=ext4 init=/sbin/init"

CORE_IMAGE_EXTRA_INSTALL += " \
	openssh \
    rsync \
    gdb \
    strace \
    valgrind \
    nano \
"
