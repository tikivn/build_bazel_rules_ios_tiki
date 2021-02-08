"""
This module contains wrapper rules for building and testing an iOS platform application.
"""

load(
    "@build_bazel_rules_apple//apple:ios.bzl",
    "ios_application",
    "ios_unit_test",
)
load(
    "@build_bazel_rules_swift//swift:swift.bzl",
    "swift_library",
)
load(
    "//config:configs.bzl",
    "swift_library_compiler_flags",
)
load(
    "//config:constants.bzl",
    "MINIMUM_IOS_VERSION",
    "PRODUCT_BUNDLE_IDENTIFIER_PREFIX",
    "SWIFT_VERSION",
)

def tk_ios_unit_test(
        name,
        srcs = [],
        deps = [],
        visibility = ["//visibility:public"]):
    """Builds and bundles an iOS Unit .xctest test bundle.

    Args:
        name: A unique base name for this unit test bundle.
        srcs: A list of targets that contains the source code of the unit test bundle.
        deps: A list of targets that the unit test bundle depends on,
            which will be linked into this library.
        visibility: The visibility attribute on a target controls
            whether the target can be used in other packages.
    """

    test_lib_name = name + "Tests-Lib"
    host_application = ":" + name
    swift_library(
        name = test_lib_name,
        srcs = srcs,
        deps = deps + [host_application],
        module_name = test_lib_name,
        visibility = ["//visibility:private"],
    )

    test_name = name + "Tests"
    ios_unit_test(
        name = test_name,
        deps = [test_lib_name],
        minimum_os_version = MINIMUM_IOS_VERSION,
        visibility = visibility,
    )

def tk_swift_library(
        name,
        deps = [],
        data = [],
        test_deps = [],
        swift_compiler_flags = [],
        swift_version = SWIFT_VERSION,
        visibility = ["//visibility:public"]):
    """Compiles and links Swift code into a static library and Swift module.

    Args:
        name: A unique name for the library.
        deps: A list of targets that this library depends on, which will be linked into this library.
        data: A list of files needed by this target at runtime.
        test_deps: A list of targets that the unit test bundle of this library depends on, which will be linked into this library.
        swift_compiler_flags: Additional compiler options.
        swift_version: Swift version to build.
        visibility: The visibility attribute on a target controls whether the target can be used in other packages.
    """
    tk_ios_unit_test(
        name = name,
        srcs = native.glob(["Tests/**/*.swift"]),
        deps = test_deps,
    )

    swift_library(
        name = name,
        module_name = name,
        srcs = native.glob(["Sources/**/*.swift"]),
        deps = deps,
        copts = swift_compiler_flags +
                swift_library_compiler_flags() +
                ["-swift-version", swift_version],
        data = data,
        visibility = visibility,
    )

def tk_ios_application(
        name,
        infoplist,
        deps = [],
        test_deps = [],
        app_icons = [],
        resources = [],
        swift_version = SWIFT_VERSION):
    """Builds and bundles an iOS application.

    Args:
        name: A unique name for this application.
        infoplist: A list of .plist files that will be merged to form the Info.plist
            that represents the application.
            At least one file must be specified
        deps: A list of dependencies targets to link into the binary.
            Any resources, such as asset catalogs, that are referenced by those targets
            will also be transitively included in the final application.
        test_deps: A list of targets that the unit test bundle of this applicatipn depends on,
            which will be linked into this library.
        app_icons: Files that comprise the app icons for the application.
            Each file must have a containing directory named *.xcassets/*.appiconset
            and there may be only one such .appiconset directory in the list.
        resources: A list of associated resource bundles or files that will be bundled into the final bundle
        swift_version: Swift version to build.
    """
    tk_swift_library(
        name = name + "Lib",
        deps = deps,
        test_deps = test_deps,
        swift_version = swift_version,
    )

    ios_application(
        name = name,
        bundle_id = PRODUCT_BUNDLE_IDENTIFIER_PREFIX + "." + name,
        families = [
            "iphone",
            "ipad",
        ],
        app_icons = app_icons,
        infoplists = [infoplist],
        minimum_os_version = MINIMUM_IOS_VERSION,
        resources = resources,
        deps = deps + [":" + name + "Lib"],
    )
