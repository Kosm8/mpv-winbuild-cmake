ExternalProject_Add(name
    DEPENDS
        name
    GIT_REPOSITORY url
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_REMOTE_NAME origin
    GIT_TAG branch/tag/sha
    GIT_RESET sha
    UPDATE_COMMAND ""
    PATCH_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 meson <BINARY_DIR> <SOURCE_DIR>
        --prefix=${MINGW_INSTALL_PREFIX}
        --libdir=${MINGW_INSTALL_PREFIX}/lib
        --cross-file=${MESON_CROSS}
        --buildtype=release
        --default-library=static
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(name)
force_meson_configure(name)
cleanup(name install)
