"""
This module contains functions to select configurations associated with an environments.
The availlable environments:
    - develop
    - staging
    - production
"""

package(default_visibility = ["//visibility:public"])

config_setting(
    name = "develop",
    values = {
        "define": "environment=develop",
    },
    visibility = ["//visibility:public"],
)

config_setting(
    name = "staging",
    values = {
        "define": "environment=staging",
    },
)

config_setting(
    name = "production",
    values = {
        "define": "environment=production",
    },
)
