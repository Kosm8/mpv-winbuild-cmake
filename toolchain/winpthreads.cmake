ExternalProject_Add(winpthreads
    DEPENDS
        mingw-w64-crt
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${MINGW_SRC}
    CONFIGURE_COMMAND ${EXEC} <SOURCE_DIR>/mingw-w64-libraries/winpthreads/configure
        "CFLAGS='-flto=thin'"
        "CXXFLAGS='-flto=thin'"
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --enable-static
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(winpthreads install)
