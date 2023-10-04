#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/libopenldap.sh

# Load LDAP environment variables
eval "$(ldap_env)"

# Ensure all OpenLDAP environment variables are valid
ldap_validate

# Ensure 'daemon' user exists when running as 'root'
if am_i_root; then
    info "Ensuring that the user: $LDAP_DAEMON_USER and group $LDAP_DAEMON_GROUP exist"
    ensure_group_exists "$LDAP_DAEMON_GROUP" --gid 1001
    ensure_user_exists "$LDAP_DAEMON_USER" --uid 1001 --system --group "$LDAP_DAEMON_GROUP" --append-groups root,dialout
fi

if ! is_ldap_setup; then
    # Ensure OpenLDAP is stopped when this script ends
    trap "ldap_stop" EXIT

    # Ensure the OpenLDAP server is initialize
    ldap_initialize

    # Allow running custom initialization scripts
    info "Load any user-provided custom initialization scripts"
    ldap_custom_init_scripts

    # Note that we've finished setup successfully, don't do this twice
    touch "$LDAP_VOLUME_DIR/.ldap_setup_complete"
else
    ensure_dir_exists $(dirname "$LDAP_PID_FILE") ${LDAP_DAEMON_USER} ${LDAP_DAEMON_GROUP}
fi
