DESCRIPTION = "Streamit MLB base image"

require recipes-rk/images/rk-image-multimedia.bb

IMAGE_FSTYPES += " streamit-mlb-gpt-img streamit-mlb-sd-img" 

CORE_IMAGE_EXTRA_INSTALL += " \
	openssh \
    rsync \
    gdb \
    strace \
    valgrind \
    nano \
"
