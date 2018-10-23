# libmali objects location changed to 29mirror branch

SRC_URI = " \
        https://github.com/rockchip-linux/libmali/raw/29mirror/lib/${MALI_TUNE}/${MALI_NAME} \
"
SRCREV = "${AUTOREV}"

SRC_URI[md5sum] = "65a1553acdc8ce158d9245fc142dd0af"
SRC_URI[sha256sum] = "ce09b52ce5ee596665567bab865bce15484eb5a888743abe13a5a9f670cba768"
