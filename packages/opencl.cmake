ExternalProject_Add(opencl
    DEPENDS opencl-header
    GIT_REPOSITORY https://github.com/KhronosGroup/OpenCL-ICD-Loader.git
    SOURCE_DIR ${SOURCE_LOCATION}
    GIT_CLONE_FLAGS "--filter=tree:0"
    UPDATE_COMMAND ""
    GIT_REMOTE_NAME origin
    GIT_TAG main
    CONFIGURE_COMMAND ${EXEC} cmake -E copy ${CMAKE_CURRENT_SOURCE_DIR}/OpenCL.pc.in <SOURCE_DIR>/OpenCL.pc.in && cmake -H<SOURCE_DIR> -B<BINARY_DIR>
        -DCMAKE_BUILD_TYPE=Release
        -DCMAKE_INSTALL_PREFIX=${MINGW_INSTALL_PREFIX}
	-DOPENCL_ICD_LOADER_HEADERS_DIR=${MINGW_INSTALL_PREFIX}/include
        -DCMAKE_TOOLCHAIN_FILE=${TOOLCHAIN_FILE}
        -DENABLE_WERROR=OFF
        -DOPENCL_ICD_LOADER_BUILD_SHARED_LIBS=OFF
        -DOPENCL_ICD_LOADER_DISABLE_OPENCLON12=ON
        -DOPENCL_ICD_LOADER_PIC=ON
        -DOPENCL_ICD_LOADER_BUILD_TESTING=OFF
        -DBUILD_TESTING=OFF
    BUILD_COMMAND ${MAKE} -C <BINARY_DIR>
    INSTALL_COMMAND ${MAKE} -C <BINARY_DIR> install
    LOG_DOWNLOAD 1 LOG_UPDATE 1 LOG_CONFIGURE 1 LOG_BUILD 1 LOG_INSTALL 1
)
force_rebuild_git(opencl)
cleanup(opencl install)
