ExternalProject_Add(ffmpeg
    DEPENDS
        bzip2
        dav1d
        fontconfig
        harfbuzz
        lcms2
        libaribcaption
        libass
        libbs2b
        libplacebo
        libpng
        libxml2
        libzimg
        libzvbi
        ${nvcodec_headers}
        shaderc
    GIT_REPOSITORY https://github.com/FFmpeg/FFmpeg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--sparse --filter=tree:0"
    GIT_CLONE_POST_COMMAND "sparse-checkout set --no-cone /* !tests/ref/fate"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --pkg-config-flags=--static
        --enable-cross-compile
        --enable-runtime-cpudetect
        #${ffmpeg_hardcoded_tables}
        --enable-gpl
        --enable-version3
        --disable-doc
        --disable-ffplay
        --disable-ffprobe
        --disable-vdpau
        --disable-videotoolbox
        ${ffmpeg_cuda}
        --enable-lcms2
        --enable-libaribcaption
        --enable-libass
        --enable-libbs2b
        --enable-libdav1d
        --enable-libfontconfig
        --enable-libfreetype
        --enable-libfribidi
        --enable-libharfbuzz
        --enable-libplacebo
        --enable-libshaderc
        --enable-libxml2
        --enable-libzimg
        --enable-libzvbi
        --enable-opengl
        --enable-schannel
        ${ffmpeg_lto}
        --extra-cflags='-Wno-error=int-conversion'
        --extra-libs='${ffmpeg_extra_libs}' # -lstdc++ / -lc++ needs by libjxl and shaderc
        --nvccflags='-O3 -ffast-math'
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
cleanup(ffmpeg install)
