"""
This module contains functions to select building artifacts associated with an environment.
"""

load(
    "//config:constants.bzl",
    "SWIFT_DEBUG_COMPILER_FLAGS",
    "SWIFT_RELEASE_COMPILER_FLAGS",
)

def swift_library_compiler_flags():
    """Return Swift compiler flags associated with an environment
    """
    return select({
        "//config:develop": SWIFT_DEBUG_COMPILER_FLAGS,
        "//config:staging": SWIFT_DEBUG_COMPILER_FLAGS,
        "//config:production": SWIFT_RELEASE_COMPILER_FLAGS,
        "//conditions:default": SWIFT_RELEASE_COMPILER_FLAGS,
    })
