ExternalProject_Add(llvm-compiler-rt-builtin
    DEPENDS
        mingw-w64-headers
        mingw-w64-crt
    DOWNLOAD_COMMAND ""
    UPDATE_COMMAND ""
    SOURCE_DIR ${LLVM_SRC}
    LIST_SEPARATOR ,
    CONFIGURE_COMMAND ${EXEC} CONF=1 cmake -H<SOURCE_DIR>/compiler-rt/lib/builtins -B<BINARY_DIR>
        -G Ninja
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${CMAKE_INSTALL_PREFIX}/lib/clang/${clang_version}
        -DCMAKE_C_COMPILER=${TARGET_ARCH}-clang
        -DCMAKE_CXX_COMPILER=${TARGET_ARCH}-clang++
        -DCMAKE_SYSTEM_NAME=Windows
        -DCMAKE_AR=${CMAKE_INSTALL_PREFIX}/bin/llvm-ar
        -DCMAKE_RANLIB=${CMAKE_INSTALL_PREFIX}/bin/llvm-ranlib
        -DCMAKE_C_COMPILER_WORKS=1
        -DCMAKE_CXX_COMPILER_WORKS=1
        -DCMAKE_C_COMPILER_TARGET=${TARGET_CPU}-w64-windows-gnu
        -DCOMPILER_RT_DEFAULT_TARGET_ONLY=TRUE
        -DCOMPILER_RT_USE_BUILTINS_LIBRARY=TRUE
        -DCOMPILER_RT_BUILD_BUILTINS=TRUE
        ${compiler_rt_cet}
        -DLLVM_CONFIG_PATH=""
        -DCMAKE_FIND_ROOT_PATH=${MINGW_INSTALL_PREFIX}
        -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY
        -DCMAKE_FIND_ROOT_PATH_MODE_PACKAGE=ONLY
        -DSANITIZER_CXX_ABI=libc++
    BUILD_COMMAND ${EXEC} LTO=0 ninja -C <BINARY_DIR>
          COMMAND bash -c "cp <BINARY_DIR>/lib/windows/libclang* ${MINGW_INSTALL_PREFIX}/lib"
    INSTALL_COMMAND ${EXEC} LTO=0 ninja -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)

cleanup(llvm-compiler-rt-builtin install)
