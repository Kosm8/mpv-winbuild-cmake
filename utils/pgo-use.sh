#!/bin/sh
cmake -DTARGET_ARCH=x86_64-w64-mingw32 \
-DGCC_ARCH=native \
-DSINGLE_SOURCE_LOCATION=../src_packages \
-DCOMPILER_TOOLCHAIN=clang \
-DLLVM_ENABLE_LTO=Thin \
-DENABLE_CCACHE=ON \
-DCLANG_PACKAGES_LTO=ON \
-DCLANG_PACKAGES_PGO_USE=ON \
-DCLANG_PACKAGES_PGO_GEN=OFF \
-DCLANG_PACKAGES_PGO_USE_PATH="/build/pgo.profdata" \
-DCLANG_FLAGS="-mprefer-vector-width=256" \
-G Ninja \
-B /build
./utils/download.sh
