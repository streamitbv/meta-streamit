DESCRIPTION = "Streamit MLB image with XFCE installed"

IMAGE_FEATURES += "\
	package-management \
    x11 \
"

#GPTIMG_APPEND = "console=tty1 console=ttyS2,115200n8 rw root=/dev/mmcblk0p7 rootfstype=ext4 init=/sbin/init"

LICENSE = "MIT"

inherit core-image

TASK_INSTALL = " \
	resize2fs \
	dvfs-rules \
"

RF_INSTALL = " \
	brcm-patchram-plus \
"

CORE_IMAGE_EXTRA_INSTALL += " \
	io \
	${TASK_INSTALL} \
	${RF_INSTALL} \
	${@bb.utils.contains('DISTRO_FEATURES', 'x11', '', '', d)} \
	${@bb.utils.contains('DISTRO_FEATURES', 'wayland', \
						'weston weston-init weston-examples weston-ini', '', d)} \
    alsa-utils \
    libdrm-rockchip \
    packagegroup-rk-gstreamer-full \
    gstreamer1.0-libav \
    packagegroup-xfce-base \
    openssh \
    rsync \
    gdb \
    valgrind \
    nano \
"

