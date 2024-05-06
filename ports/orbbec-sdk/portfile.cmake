vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO orbbec/OrbbecSDK
        REF "v${VERSION}"
        SHA512 72874b8bea22812aeb67fff8de01c0daaceb56112f348db522e31be7c7dc1bda2a067f166d40ceb2352076b4b7c8eeddf13f166e7d8f6eda49d432fb7069dc3c
        HEAD_REF main
        PATCHES
            001-vcpkg-compat.patch
)

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
            -DBUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
        PACKAGE_NAME OrbbecSDK
        CONFIG_PATH "share/cmake/OrbbecSDK"
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE.txt")

# Handle usage
file(
        INSTALL "${CMAKE_CURRENT_LIST_DIR}/usage"
        DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
)
