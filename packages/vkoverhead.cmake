ExternalProject_Add(vkoverhead
    GIT_REPOSITORY https://github.com/zmike/vkoverhead.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_TAG main
    GIT_REMOTE_NAME origin
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson setup <BINARY_DIR> <SOURCE_DIR>
        --prefix=${MINGW_INSTALL_PREFIX}
        --libdir=${MINGW_INSTALL_PREFIX}/lib
        --cross-file=${MESON_CROSS}
        --default-library=static
        --buildtype=release
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
            COMMAND bash -c "cp <BINARY_DIR>/vkoverhead.exe ${MINGW_INSTALL_PREFIX}/bin"
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(vkoverhead)
force_meson_configure(vkoverhead)
cleanup(vkoverhead install)
