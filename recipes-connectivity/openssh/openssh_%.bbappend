do_install_append () {
    sed -i -e 's/#PermitRootLogin yes/PermitRootLogin no/' ${D}${sysconfdir}/ssh/sshd_config
}
