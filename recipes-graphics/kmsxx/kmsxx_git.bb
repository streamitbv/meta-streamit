LICENSE="MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=c670e18272184fc0e86e1648678b4f2a \
                    file://ext/pybind11/LICENSE;md5=beb87117af69fd10fbf9fb14c22a2e62 \
                    file://ext/pybind11/tools/clang/LICENSE.TXT;md5=dfabea443c6c16b6321441a8c8c19705"

SRC_URI = "gitsm://github.com/tomba/kmsxx.git;protocol=https"

PV = "1.0+git${SRCPV}"
SRCREV = "37dfa5c785f7cc48ff9458881d907e2cce7d4fa6"

S = "${WORKDIR}/git"

DEPENDS = "libdrm"

inherit cmake pkgconfig

EXTRA_OECMAKE = "-DKMSXX_ENABLE_PYTHON=off"
