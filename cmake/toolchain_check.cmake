if(COMPILER_TOOLCHAIN STREQUAL "gcc")
    set(gcc_install "gcc-install")
    set(binutils "binutils")
elseif(COMPILER_TOOLCHAIN STREQUAL "clang")
    set(llvm_wrapper "llvm-wrapper")
    set(llvm_libcxx "llvm-libcxx")
    set(cfguard "--enable-cfguard")
    set(opt "-O3 -mllvm --polly -mllvm --polly-position=before-vectorizer -mllvm --polly-scheduling=dynamic -mllvm --polly-ast-use-context -mllvm --polly-vectorizer=stripmine -mllvm --polly-run-dce -mllvm --polly-invariant-load-hoisting -mllvm --polly-run-inliner")
endif()

if(TARGET_CPU STREQUAL "x86_64")
    set(crt_lib "--disable-lib32 --enable-lib64")
    set(LIBOMP_ASMFLAGS_M64 "-DLIBOMP_ASMFLAGS=-m64")
    set(cfi "-mguard=cf -fcf-protection=full")
    if (GCC_ARCH STREQUAL "x86-64")
        unset(opt)
        unset(cfi)
    endif()
elseif(TARGET_CPU STREQUAL "i686")
    set(crt_lib "--enable-lib32 --disable-lib64")
    unset(opt)
elseif(TARGET_CPU STREQUAL "aarch64")
    set(crt_lib "--disable-lib32 --disable-lib64 --enable-libarm64")
    set(cfi "-mguard=cf")
endif()
