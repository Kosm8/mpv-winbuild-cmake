if(COMPILER_TOOLCHAIN STREQUAL "gcc")
    set(vapoursynth_pkgconfig_libs "-lvapoursynth")
    set(vapoursynth_script_pkgconfig_libs "-lvsscript")
    set(vapoursynth_manual_install_copy_lib COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/libvsscript.a ${MINGW_INSTALL_PREFIX}/lib/libvsscript.a
                                            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/libvapoursynth.a ${MINGW_INSTALL_PREFIX}/lib/libvapoursynth.a)
    set(ffmpeg_extra_libs "-lstdc++")
    set(libjxl_unaligned_vector "-Wa,-muse-unaligned-vector-move") # fix crash on AVX2 proc (64bit) due to unaligned stack memory
    set(mpv_copy_debug COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.debug ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/mpv.debug)
    set(mpv_add_debuglink COMMAND ${EXEC} ${TARGET_ARCH}-objcopy --only-keep-debug <BINARY_DIR>/mpv.exe <BINARY_DIR>/mpv.debug
                          COMMAND ${EXEC} ${TARGET_ARCH}-strip -s <BINARY_DIR>/mpv.exe
                          COMMAND ${EXEC} ${TARGET_ARCH}-objcopy --add-gnu-debuglink=<BINARY_DIR>/mpv.debug <BINARY_DIR>/mpv.exe)
    set(rust_target "gnu")
elseif(COMPILER_TOOLCHAIN STREQUAL "clang")
    set(vapoursynth_pkgconfig_libs "-lVapourSynth -Wl,-delayload=VapourSynth.dll")
    set(vapoursynth_script_pkgconfig_libs "-lVSScript -Wl,-delayload=VSScript.dll")
    set(vapoursynth_manual_install_copy_lib COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/VSScript.lib ${MINGW_INSTALL_PREFIX}/lib/VSScript.lib
                                            COMMAND ${CMAKE_COMMAND} -E copy <SOURCE_DIR>/VapourSynth.lib ${MINGW_INSTALL_PREFIX}/lib/VapourSynth.lib)
    set(ffmpeg_extra_libs "-lc++")
    set(ffmpeg_hardcoded_tables "--enable-hardcoded-tables")
    set(mpv_lto_mode "-Db_lto_mode=thin")
    set(mpv_copy_debug COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/mpv.pdb ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/mpv.pdb
                       COMMAND ${CMAKE_COMMAND} -E copy <BINARY_DIR>/libmpv-2.pdb ${CMAKE_CURRENT_BINARY_DIR}/mpv-debug/libmpv-2.pdb)
    set(rust_target "gnullvm")
    if(CLANG_PACKAGES_LTO)
        if(TARGET_CPU STREQUAL "x86_64")
            set(rust_cfi "-Z cf-protection=full")
        endif()
        set(cargo_lto_rustflags "CARGO_PROFILE_RELEASE_LTO=thin
                                 RUSTFLAGS='-C target-cpu=${GCC_ARCH} -C control-flow-guard=yes -C linker-plugin-lto -C embed-bitcode -C lto=thin -C llvm-args=-fp-contract=fast -Z threads=${CPU_COUNT} ${rust_cfi}'")
        set(ffmpeg_lto "--enable-lto=thin")
        if(NOT (GCC_ARCH_HAS_AVX OR (TARGET_CPU STREQUAL "aarch64")))
            set(zlib_nlto "LTO=0")
        endif()
    endif()
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(dlltool_image "i386:x86-64")
    set(openssl_target "mingw64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "x86_64-win64-gcc")
    set(vapoursynth "vapoursynth")
    set(ffmpeg_vapoursynth "--enable-vapoursynth")
    set(mpv_vapoursynth "-Drubberband=enabled")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(xxhash_cflags "-DXXH_X86DISPATCH_ALLOW_AVX=1")
    set(nvcodec-headers "nvcodec-headers")
    set(vvdec_simd "VVDEC_ENABLE_X86_SIMD=ON VVDEC_ENABLE_ARM_SIMD=OFF")
    set(vvenc_simd "VVENC_ENABLE_X86_SIMD=ON VVENC_ENABLE_ARM_SIMD=OFF")
    set(ffmpeg_cuda "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc")
elseif(TARGET_CPU STREQUAL "i686")
    set(dlltool_image "i386")
    set(openssl_target "mingw")
    set(libvpx_target "x86-win32-gcc")
    set(vapoursynth "vapoursynth")
    set(ffmpeg_vapoursynth "--enable-vapoursynth")
    set(mpv_vapoursynth "-Drubberband=enabled")
    set(mpv_gl "-Dgl=enabled -Degl-angle=enabled")
    set(xxhash_dispatch "-DDISPATCH=ON")
    set(xxhash_cflags "-DXXH_X86DISPATCH_ALLOW_AVX=1")
    set(nvcodec-headers "nvcodec-headers")
    set(vvdec_simd "VVDEC_ENABLE_X86_SIMD=ON VVDEC_ENABLE_ARM_SIMD=OFF")
    set(vvenc_simd "VVENC_ENABLE_X86_SIMD=ON VVENC_ENABLE_ARM_SIMD=OFF")
    set(ffmpeg_cuda "--enable-cuda-llvm --enable-cuvid --enable-nvdec --enable-nvenc")
elseif(TARGET_CPU STREQUAL "aarch64")
    set(dlltool_image "arm64")
    set(openssl_target "mingw-arm64")
    set(openssl_ec_opt "enable-ec_nistp_64_gcc_128")
    set(libvpx_target "arm64-win64-gcc")
    set(libvpx_neon "--disable-neon-i8mm --disable-neon-dotprod")
    set(mpv_gl "-Dgl=disabled -Degl-angle=disabled")
    set(vvdec_simd "VVDEC_ENABLE_X86_SIMD=OFF VVDEC_ENABLE_ARM_SIMD=ON")
    set(vvenc_simd "VVENC_ENABLE_X86_SIMD=OFF VVENC_ENABLE_ARM_SIMD=ON")
    set(aom_neon "-DENABLE_NEON_DOTPROD=OFF -DENABLE_NEON_I8MM=OFF -DHAVE_NEON_DOTPROD=OFF -DHAVE_NEON_I8MM=OFF -DCONFIG_RUNTIME_CPU_DETECT=OFF")
endif()
