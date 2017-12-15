DESCRIPTION = "Streamit MLB base image"

require recipes-rk/images/rk-image-multimedia.bb

IMAGE_FSTYPES += " streamit-mlb-gpt-img streamit-mlb-sd-img" 

inherit extrausers

EXTRA_USERS_PARAMS ?= " \
    useradd -p '\$6\$WTl6/ng22ijfBklW\$a3jrDgN3d8uLMtyCifKG33PNo0/K5L1Je.ulHEtxZzjSNFUsX.GPYQcYA7IzRGh5CAu82l3QjiRSwaxGCKctY0' -s '/bin/bash' waveuser; \
    usermod -aG sudo waveuser; \
    usermod -aG audio waveuser; \
    usermod -p '!' root; \
"
CORE_IMAGE_EXTRA_INSTALL += " \
    sudo \
	openssh \
    rsync \
    nano \
    av-wrappers \
    openjdk-8 \
    chromium \
"
