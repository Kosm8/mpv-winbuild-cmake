ExternalProject_Add(mpv-menu-plugin
    DEPENDS
        mpv
    GIT_REPOSITORY https://github.com/tsl0922/mpv-menu-plugin.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_TAG main
    GIT_REMOTE_NAME origin
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
        -DCMAKE_FIND_ROOT_PATH=${MINGW_INSTALL_PREFIX}
        -DBUILD_SHARED_LIBS=OFF
    BUILD_COMMAND ${EXEC} ninja -C <BINARY_DIR>
    INSTALL_COMMAND bash -c "cp <BINARY_DIR>/menu.dll ${MINGW_INSTALL_PREFIX}/bin"
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(mpv-menu-plugin)
cleanup(mpv-menu-plugin install)
