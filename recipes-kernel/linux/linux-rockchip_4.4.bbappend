SRC_URI = " \
        git://github.com/streamitbv/kernel.git;branch=release-4.4; \
"
SRCREV = "24de3eaeab49b1a514e77d1366ef381150805572"
LINUX_VERSION = "4.4.83"

do_copy_binary_driver () {
    mkdir -p "${B}/drivers/gpu/drm/rockchip"
    cp "${S}/drivers/gpu/drm/rockchip/lt8618.o" "${B}/drivers/gpu/drm/rockchip/lt8618.o"
}
addtask copy_binary_driver before do_compile after do_configure
