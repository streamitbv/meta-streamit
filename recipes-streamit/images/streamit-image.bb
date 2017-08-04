# Copyright (C) 2017 Fuzhou Rockchip Electronics Co., Ltd
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "A image with Rockchip's multimedia and browser packages."

require recipes-rk/images/rk-image-multimedia.bb

GPTIMG_APPEND = "console=tty1 console=ttyS2,115200n8 rw root=/dev/mmcblk0p7 rootfstype=ext4 init=/sbin/init"

CORE_IMAGE_EXTRA_INSTALL += " \
	openssh \
    rsync \
	ffmpeg-dev \
	mpv \
    gnupg \
    chromium \ 
"

# IMAGE_INSTALL = "ffmpeg"
