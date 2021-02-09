"""
This module contains shared constants.
"""

SWIFT_VERSION = "5"

MINIMUM_IOS_VERSION = "9.0"

PRODUCT_BUNDLE_IDENTIFIER_PREFIX = "dev.duytph"

# Compiler flags

SWIFT_COMPILER_FLAGS = [
    "-whole-module-optimization",
]

SWIFT_DEBUG_COMPILER_FLAGS = [
    # Enable the DEBUG flag, for using it in macros
    "-DDEBUG",
    # Do not make optimizations: compilation is faster
    "-Onone",
    # Print debug information
    "-g",
    # Make libraries testable
    "-enable-testing",
] + SWIFT_COMPILER_FLAGS

SWIFT_RELEASE_COMPILER_FLAGS = [
    # Enable the DEBUG flag, for using it in macros
    "-DRELEASE",
    # Make optimizations: compilation is faster
    "-Osize",
] + SWIFT_COMPILER_FLAGS
