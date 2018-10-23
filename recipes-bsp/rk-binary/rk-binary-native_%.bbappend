#
DESCRIPTION = "Rockchip binary tools, uses Streamit manifest"

# override the SRC_URI to a known safe source eventhough we dont use it
# this is preferable to an empty SRC_URI to disable fetching
SRC_URI = "git://github.com/streamitbv/rkbin.git"
SRCREV = "${AUTOREV}"

LIC_FILES_CHKSUM = "file://${TOPDIR}/../rkbin/LICENSE.TXT;md5=564e729dd65db6f65f911ce0cd340cf9"

do_install () {
        install -d ${D}/${bindir}
        install -m 0755 "${TOPDIR}/../rkbin/tools/trust_merger" ${D}/${bindir}
        install -m 0755 "${TOPDIR}/../rkbin/tools/firmwareMerger" ${D}/${bindir}

        install -m 0755 "${TOPDIR}/../rkbin/tools/kernelimage" ${D}/${bindir}
        install -m 0755 "${TOPDIR}/../rkbin/tools/loaderimage" ${D}/${bindir}

        install -m 0755 "${TOPDIR}/../rkbin/tools/mkkrnlimg" ${D}/${bindir}
        install -m 0755 "${TOPDIR}/../rkbin/tools/resource_tool" ${D}/${bindir}

}


