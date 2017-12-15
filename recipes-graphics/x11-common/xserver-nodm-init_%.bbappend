do_install_append() {
    rm ${D}${sysconfdir}/X11/Xsession.d/13xdgbasedirs.sh
}
