ExternalProject_Add(aria2
    DEPENDS
        libxml2
        libssh2
        c-ares
        sqlite
        zlib
    GIT_REPOSITORY https://github.com/Andarwinux/aria2.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && CONF=1 <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --enable-static
        --with-libcares
        --with-libssh2
        --with-libxml2
        --with-sqlite3
        --with-wintls
        --with-libz
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(aria2)
cleanup(aria2 install)
