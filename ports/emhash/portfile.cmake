
set(SHA_CORE                a1bd9fb71d7be2e7d0b2546f0ec172e6044c2709faf535cd3b5e263abea519940421aa149987c90972a44cafddf23c3972cf39c36d19cdabdf18b6dc6d8859da)

vcpkg_from_github(
	OUT_SOURCE_PATH SOURCE_PATH
	REPO ktprime/emhash
	REF v${VERSION}
	SHA512 "${SHA_CORE}"
)
file(REMOVE_RECURSE "${SOURCE_PATH}/thirdparty")

vcpkg_cmake_configure(
	SOURCE_PATH "${SOURCE_PATH}"
	OPTIONS
		"-D WITH_BENCHMARKS=OFF"
		"-D WITH_EXAMPLES=OFF"
		"-D WITH_TESTS=OFF"
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
	CONFIG_PATH "lib/cmake/emhash"
)
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")
