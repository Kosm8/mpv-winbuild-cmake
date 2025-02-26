ExternalProject_Add(gcc
    DEPENDS
        mingw-w64-headers
    GIT_REPOSITORY https://github.com/Kosm8/gcc.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    GIT_TAG releases/gcc-15
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND <SOURCE_DIR>/configure
        --target=${TARGET_ARCH}
        --prefix=${CMAKE_INSTALL_PREFIX}
        --libdir=${CMAKE_INSTALL_PREFIX}/lib
        --without-included-gettext
        --with-sysroot=${CMAKE_INSTALL_PREFIX}
        --program-prefix=cross-
        --disable-checking
        --disable-libgomp
        --disable-multilib
        --disable-nls
        --disable-shared
        --disable-sjlj-exceptions
        --disable-win32-registry
        --enable-default-pie
        --enable-host-bind-now
        --enable-host-pie
        --enable-languages=c,c++
        --enable-libstdcxx-threads=yes
        --enable-lto
        --enable-threads=win32
    BUILD_COMMAND make -j${MAKEJOBS} all-gcc
    INSTALL_COMMAND make install-strip-gcc
    STEP_TARGETS download install
    LOG_DOWNLOAD 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

ExternalProject_Add_Step(gcc final
    DEPENDS
        mingw-w64-crt
        winpthreads
        gendef
        rustup
        cppwinrt
    COMMAND ${MAKE}
    COMMAND ${MAKE} install-strip
    WORKING_DIRECTORY <BINARY_DIR>
    LOG 1
)

force_rebuild_git(gcc)
cleanup(gcc final)
