ExternalProject_Add(libass
    DEPENDS
        harfbuzz
        freetype2
        fribidi
        libiconv
        fontconfig
        libunibreak
    GIT_REPOSITORY https://github.com/libass/libass.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS ""
    PATCH_COMMAND ${EXEC} curl -sL https://github.com/libass/libass/pull/793.patch | git am --3way --whitespace=fix
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} autoreconf -fi && CONF=1 <SOURCE_DIR>/configure
        --host=${TARGET_ARCH}
        --prefix=${MINGW_INSTALL_PREFIX}
        --disable-shared
        --disable-pthreads
        CFLAGS='-Wno-error=int-conversion'
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    BUILD_IN_SOURCE 1
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_PATCH 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(libass)
cleanup(libass install)
