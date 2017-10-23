SRC_URI = " \
	git://github.com/streamitbv/u-boot.git;branch=release; \
"

SRCREV = "${AUTOREV}"
PV = "v2017.05+git${SRCPV}"
S = "${WORKDIR}/git"

do_compile_append () {
	# copy to default search path
	if [ ${SPL_BINARY} ]; then
		cp ${B}/spl/${SPL_BINARY} ${B}/
	fi
}
