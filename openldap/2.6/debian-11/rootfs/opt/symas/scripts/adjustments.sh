#!/bin/bash
# Copyright Symas Corp, 2023
# SPDX-License-Identifier: APACHE-2.0

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail

# Fix inconsistencies in a way that downstream script expectations are met.

# Their OpenLDAP tree of files is rooted in /opt/bitnami/openldap while Symas
# packages are in /opt/symas
mv /opt/symas /opt/bitnami/openldap
ln -s /opt/bitnami/openldap /opt/symas

# Sometimes Symas places things into a subdir called "openldap" where Bitnami
# and others don't.
ln -s /opt/bitnami/openldap/etc/openldap/schema /opt/bitnami/openldap/etc/schema

# We need to setcap on a binary, so hard link it to the expected location.
ln /opt/bitnami/openldap/lib/slapd /opt/bitnami/openldap/sbin/slapd

# No need to include the following.
rm -rf /opt/bitnami/openldap/share/{doc,man,symas}
