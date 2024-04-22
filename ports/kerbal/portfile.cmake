vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO WentsingNee/Kerbal
        REF "v${VERSION}"
        SHA512 1c3ce10da33679868c1f634eef02b596ce58c18711cd40751ab452a9ec01070434b842c4e5860ff9a5ed69f1bdab882aa0a9559e455f22e4e09b37c2b82bb2ec
        HEAD_REF main
)


vcpkg_check_features(OUT_FEATURE_OPTIONS FEATURE_OPTIONS
        FEATURES
            "pretty-printer"       WITH_PRETTY_PRINTER
)

if (WITH_PRETTY_PRINTER)
    vcpkg_from_github(
            OUT_SOURCE_PATH SOURCE_PATH_PRETTY_PRINTER
            REPO WentsingNee/KerbalPrettyPrinter
            REF "v${VERSION}"
            SHA512 427ffb87cd8f5428fd68646b9855f453e136d6e8009fe084361137cf291f56ba1f7208e3e5d9b7f82577bf20f382dc3b92897f8fdbeb3e99733e647c3c1a3180
            HEAD_REF main
    )
    file(GLOB pretty_printer_files
            LIST_DIRECTORIES True
            "${SOURCE_PATH_PRETTY_PRINTER}/*"
    )
    foreach (e IN LISTS pretty_printer_files)
        file(
            COPY "${e}"
            DESTINATION "${SOURCE_PATH}/pretty_printer"
        )
    endforeach ()
endif ()

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
)
vcpkg_cmake_install()
vcpkg_cmake_config_fixup(
        CONFIG_PATH "share/cmake/Kerbal"
)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug")

vcpkg_install_copyright(FILE_LIST "${SOURCE_PATH}/LICENSE")
