cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DALWAYS_REMOVE_BUILDFILES=OFF \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DCLANG_FLAGS="-O3 -DWIN32_WINNT=0x0A00 -mprefer-vector-width=512 -pipe" \
-DLLD_FLAGS="-O3" \
-G Ninja \
-B build
ninja -C build llvm && ninja -C build llvm-clang && \
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DALWAYS_REMOVE_BUILDFILES=OFF \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DCLANG_FLAGS="-O3 -DWIN32_WINNT=0x0A00 -mprefer-vector-width=512 -pipe -fdata-sections -ffunction-sections -fvisibility=hidden" \
-DLLD_FLAGS="-O3 --gc-sections -Xlink=-opt:safeicf" \
-G Ninja \
-B build
./utils/download.sh
