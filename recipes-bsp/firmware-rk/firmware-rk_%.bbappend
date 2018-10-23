#
DESCRIPTION = "Rockchip firmware such as for the WIFI, BT, replaced by Streamit manifest"

LIC_FILES_CHKSUM = "file:///${TOPDIR}/../rkbin/LICENSE.TXT;md5=564e729dd65db6f65f911ce0cd340cf9"

# override the SRC_URI to a known safe source eventhough we dont use it
# this is preferable to an empty SRC_URI to disable fetching
SRC_URI = "git://github.com/streamitbv/rkbin.git"
SRCREV = "${AUTOREV}"

do_install () {
	install -d ${D}/system/etc/firmware/
	cp -rf ${TOPDIR}/../rkbin/firmware/wifi/* ${D}/system/etc/firmware/

	install -d ${D}/etc/firmware/
	cp -rf ${TOPDIR}/../rkbin/firmware/bluetooth/*.hcd ${D}/etc/firmware/
}
