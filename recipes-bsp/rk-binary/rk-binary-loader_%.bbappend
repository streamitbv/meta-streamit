#
DESCRIPTION = "Rockchip binary loader, uses Streamit manifest"

# override the SRC_URI to a known safe source eventhough we dont use it
# this is preferable to an empty SRC_URI to disable fetching
SRC_URI = "git://github.com/streamitbv/rkbin.git"
SRCREV = "${AUTOREV}"

LIC_FILES_CHKSUM = "file://${TOPDIR}/../rkbin/LICENSE.TXT;md5=564e729dd65db6f65f911ce0cd340cf9"

do_deploy () {
        install -d ${RKBINARY_DEPLOY_DIR}
        [ ${DDR} ] && cp ${TOPDIR}/../rkbin/${DDR} ${RKBINARY_DEPLOY_DIR}/${DDR_BIN}
        [ ${MINILOADER} ] && cp ${TOPDIR}/../rkbin/${MINILOADER} ${RKBINARY_DEPLOY_DIR}/${MINILOADER_BIN}
        [ ${LOADER} ] && cp ${TOPDIR}/../rkbin/${LOADER} ${RKBINARY_DEPLOY_DIR}/${LOADER_BIN}
        [ ${ATF} ] && cp ${TOPDIR}/../rkbin/${ATF} ${RKBINARY_DEPLOY_DIR}/${ATF_BIN}

        # Don't remove it!
        echo "done"
}

