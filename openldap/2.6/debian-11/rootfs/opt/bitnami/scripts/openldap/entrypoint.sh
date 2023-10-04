#!/bin/bash
# Copyright VMware, Inc.
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# Load libraries
. /opt/bitnami/scripts/liblog.sh

setup_failure() {
    info "** LDAP setup incomplete, unable to start service. **"
}

if [[ "$1" = "/opt/bitnami/scripts/openldap/run.sh" ]]; then
    trap "setup_failure" EXIT
    /opt/bitnami/scripts/openldap/setup.sh
fi

echo ""
exec "$@"
