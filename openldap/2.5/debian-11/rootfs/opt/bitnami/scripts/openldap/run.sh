#!/bin/bash
# Copyright VMware, Inc. 2023
# Copyright Symas Corp. 2023
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libopenldap.sh

# Load LDAP environment variables
eval "$(ldap_env)"

command="$(command -v slapd)"

# Reduce maximum number of open file descriptors
# https://github.com/docker/docker/issues/8231
ulimit -n "$LDAP_ULIMIT_NOFILES"

if is_boolean_yes "$LDAP_ENABLE_TLS"; then
    # Add LDAPS URI when TLS is enabled
    flags=("-h" "ldap://:${LDAP_PORT_NUMBER}/ ldaps://:${LDAP_LDAPS_PORT_NUMBER}/")
else
    flags=("-h" "ldap://:${LDAP_PORT_NUMBER}/")
fi

# Add "@" so users can add extra command line flags
flags+=("-F" "${LDAP_CONF_DIR}/slapd.d" "-d" "$LDAP_LOGLEVEL" "$@")

# When the container is running as root switch to the effective user
am_i_root && flags=("-u" "$LDAP_DAEMON_USER" "${flags[@]}")

info "Starting slapd ${flags[@]}"
exec "${command}" "${flags[@]}"
