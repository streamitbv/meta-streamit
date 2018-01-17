DEPENDS = "packagegroup-rk-gstreamer-full kmsxx"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "\
        file://playvideo \
        file://playaudio \
"
S = "${WORKDIR}"

do_install() {
    install -d ${D}/${bindir}
    install -m 0755 ${S}/playvideo ${D}/${bindir}
    install -m 0755 ${S}/playaudio ${D}/${bindir}
}
