SRC_URI = " \
	git://github.com/streamitbv/u-boot.git;branch=release; \
"

SRCREV = "${AUTOREV}"
PV = "v2017.05+git${SRCPV}"
S = "${WORKDIR}/git"

