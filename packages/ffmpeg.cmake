ExternalProject_Add(ffmpeg
    DEPENDS
        amf-headers
        avisynth-headers
        ${nvcodec-headers}
        bzip2
        lame
        lcms2
        openssl
        libssh
        libsrt
        libass
        libbluray
        libmodplug
        libpng
        libsoxr
        libvpx
        libwebp
        libzimg
        libmysofa
        fontconfig
        harfbuzz
        opus
        speex
        vorbis
        x265
        libxml2
        libvpl
        libopenmpt
        libjxl
        shaderc
        libplacebo
        libzvbi
        libaribcaption
        aom
        rav1e
        svtav1
        dav1d
        ${vapoursynth}
        rubberband
        libva
        openal-soft
        fdk-aac
        opencl
        vulkan
        vmaf
        vvdec
        vvenc
        directx-header
        game-music-emu
    GIT_REPOSITORY https://github.com/Andarwinux/ffmpeg.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    CONFIGURE_COMMAND ${EXEC} CONF=1 <SOURCE_DIR>/configure
        --cross-prefix=${TARGET_ARCH}-
        --prefix=${MINGW_INSTALL_PREFIX}
        --arch=${TARGET_CPU}
        --target-os=mingw32
        --pkg-config-flags=--static
        --enable-cross-compile
        --disable-runtime-cpudetect
        ${ffmpeg_hardcoded_tables}
        --enable-gpl
        --enable-version3
        --enable-nonfree
        --enable-postproc
        --enable-avisynth
        ${ffmpeg_vapoursynth}
        --enable-libass
        --enable-libbluray
        --enable-libfreetype
        --enable-libfribidi
        --enable-libfontconfig
        --enable-libharfbuzz
        --enable-libmodplug
        --enable-libopenmpt
        --enable-libmp3lame
        --enable-libgme
        --enable-lcms2
        --enable-libopus
        --enable-libsoxr
        --enable-libspeex
        --enable-libvorbis
        --enable-librubberband
        --enable-libvpx
        --enable-libwebp
        --enable-libx265
        --enable-libaom
        --enable-librav1e
        --enable-libsvtav1
        --enable-libdav1d
        --enable-libzimg
        --enable-openssl
        --enable-libxml2
        --enable-libmysofa
        --enable-libssh
        --enable-libsrt
        --enable-libvpl
        --enable-libjxl
        --enable-libplacebo
        --enable-libshaderc
        --enable-libzvbi
        --enable-libaribcaption
        ${ffmpeg_cuda}
        --enable-amf
        --enable-openal
        --enable-opengl
        --disable-doc
        --disable-ffplay
        --disable-ffprobe
        --enable-vaapi
        --enable-libfdk-aac
        --enable-libvmaf
        --enable-opencl
        --enable-openal
        --enable-opengl
        --enable-libvvdec
        --enable-libvvenc
        --disable-vdpau
        --disable-videotoolbox
        --disable-decoder=libaom_av1
        ${ffmpeg_lto}
        --extra-cflags='-I${MINGW_INSTALL_PREFIX}/include/directx -D__REQUIRED_RPCNDR_H_VERSION__=475'
        "--extra-libs='${ffmpeg_extra_libs}'" # -lstdc++ / -lc++ needs by libjxl and shaderc
        "--nvccflags='--cuda-gpu-arch=sm_86 -O3'"
    BUILD_COMMAND ${MAKE}
    INSTALL_COMMAND ${MAKE} install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

force_rebuild_git(ffmpeg)
cleanup(ffmpeg install)
