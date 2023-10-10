#!/bin/bash
# Copyright Symas Corp, 2023
# SPDX-License-Identifier: APACHE-2.0
#
# Symas OpenLDAP library

# shellcheck disable=SC1090,SC1091,SC2119,SC2120

# Symas defaults
export SYMAS_DEBUG="${SYMAS_DEBUG:-false}"

# Compatibility with Bitnami "API" meaning environment variables names.
export BITNAMI_DEBUG="${SYMAS_DEBUG}"
