ExternalProject_Add(llvm-libcxx
    DEPENDS
        llvm-compiler-rt-builtin
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${LLVM_SRC}
    LIST_SEPARATOR ,
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/runtimes -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
        -DCMAKE_C_COMPILER=${TARGET_ARCH}-clang
        -DCMAKE_CXX_COMPILER=${TARGET_ARCH}-clang++
        -DCMAKE_SYSTEM_NAME=Windows
        -DCMAKE_AR=${CMAKE_INSTALL_PREFIX}/bin/llvm-ar
        -DCMAKE_RANLIB=${CMAKE_INSTALL_PREFIX}/bin/llvm-ranlib
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_C_COMPILER_TARGET=${TARGET_CPU}-w64-windows-gnu
        -DLLVM_ENABLE_RUNTIMES='libunwind,libcxxabi,libcxx'
        -DLLVM_PATH=${LLVM_SRC}/llvm
        -DLIBUNWIND_USE_COMPILER_RT=TRUE
        -DLIBUNWIND_ENABLE_SHARED=OFF
        -DLIBUNWIND_ENABLE_STATIC=ON
        ${libcxx_cet}
        -DLIBCXX_USE_COMPILER_RT=ON
        -DLIBCXX_ENABLE_SHARED=OFF
        -DLIBCXX_ENABLE_STATIC=ON
        -DLIBCXX_ENABLE_STATIC_ABI_LIBRARY=TRUE
        -DLIBCXX_CXX_ABI=libcxxabi
        -DLIBCXX_LIBDIR_SUFFIX=""
        -DLIBCXX_INCLUDE_TESTS=FALSE
        -DLIBCXX_ENABLE_ABI_LINKER_SCRIPT=FALSE
        -DLIBCXX_HAS_WIN32_THREAD_API=ON
        -DLIBCXXABI_HAS_WIN32_THREAD_API=ON
        -DLIBCXXABI_USE_COMPILER_RT=ON
        -DLIBCXXABI_USE_LLVM_UNWINDER=ON
        -DLIBCXXABI_ENABLE_SHARED=OFF
        -DLIBCXXABI_LIBDIR_SUFFIX=""
    BUILD_COMMAND ${EXEC} LTO=0 ninja -C <BINARY_DIR>
    INSTALL_COMMAND ${EXEC} LTO=0 ninja -C <BINARY_DIR> install
            COMMAND bash -c "cp ${MINGW_INSTALL_PREFIX}/lib/libc++.a ${MINGW_INSTALL_PREFIX}/lib/libstdc++.a"
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(llvm-libcxx install)
