do_install_append () {
    sed -i 's;.*HOME.*;PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin;' ${D}${sysconfdir}/profile
}
