ExternalProject_Add(sqlite
    URL https://www.sqlite.org/2023/sqlite-autoconf-3440000.tar.gz
    URL_HASH SHA3_256=6869046465eae886f1a9f2c8debeeba44d34328693aa77a5bd4a3cfed93d6556
    DOWNLOAD_DIR ${SOURCE_LOCATION}
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && CONF=1 <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --enable-static
        --disable-shared
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(sqlite install)
