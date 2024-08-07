#!/bin/bash
# Copyright VMware, Inc. 2023
# Copyright Symas, Corp. 2023-2024
# SPDX-License-Identifier: APACHE-2.0
#
# Bitnami OpenLDAP library

# shellcheck disable=SC1090,SC1091,SC2119,SC2120

# Load libraries
. /opt/symas/scripts/libcompat.sh
. /opt/bitnami/scripts/libfile.sh
. /opt/bitnami/scripts/libfs.sh
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libos.sh
. /opt/bitnami/scripts/libservice.sh
. /opt/bitnami/scripts/libvalidations.sh

########################
# Load global variables used on OpenLDAP configuration
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   Series of exports to be used as 'eval' arguments
#########################
ldap_env() {
    cat << "EOF"
# Paths
export BASE_DIR="${BASE_DIR:-/opt/bitnami}"
export LDAP_BASE_DIR="${BASE_DIR}/openldap"
export LDAP_BIN_DIR="${LDAP_BASE_DIR}/bin"
export LDAP_SBIN_DIR="${LDAP_BASE_DIR}/sbin"
export LDAP_CONF_DIR="${LDAP_CONF_DIR:-${LDAP_BASE_DIR}/etc}"
export LDAP_SHARE_DIR="${LDAP_BASE_DIR}/share"
export LDAP_VAR_DIR="${LDAP_BASE_DIR}/var"
export LDAP_VOLUME_DIR="${LDAP_VOLUME_DIR:-/openldap}"
export LDAP_DATA_DIR="${LDAP_VOLUME_DIR}/data"
export LDAP_BACKEND_DATA_DIR="${LDAP_DATA_DIR}/backend"
export LDAP_ACCESSLOG_DATA_DIR="${LDAP_DATA_DIR}/accesslog"
export LDAP_ONLINE_CONF_DIR="${LDAP_VOLUME_DIR}/slapd.d"
export LDAP_PID_FILE="${LDAP_VAR_DIR}/run/slapd.pid"
export LDAP_ARGS_FILE="${LDAP_VAR_DIR}/run/slapd.args"
export LDAP_CUSTOM_LDIF_DIR="${LDAP_CUSTOM_LDIF_DIR:-/ldifs}"
export LDAP_CUSTOM_SCHEMA_FILE="${LDAP_CUSTOM_SCHEMA_FILE:-/schema/custom.ldif}"
export LDAP_CUSTOM_SCHEMA_DIR="${LDAP_CUSTOM_SCHEMA_DIR:-/schemas}"
export LDAP_SYSLOG_LOG_FORMAT="${LDAP_SYSLOG_LOG_FORMAT:-yes}"
export PATH="${LDAP_BIN_DIR}:${LDAP_SBIN_DIR}:$PATH"
export LDAP_TLS_CERT_FILE="${LDAP_TLS_CERT_FILE:-}"
export LDAP_TLS_KEY_FILE="${LDAP_TLS_KEY_FILE:-}"
export LDAP_TLS_CA_FILE="${LDAP_TLS_CA_FILE:-}"
export LDAP_TLS_VERIFY_CLIENTS="${LDAP_TLS_VERIFY_CLIENTS:-never}"
export LDAP_TLS_DH_PARAMS_FILE="${LDAP_TLS_DH_PARAMS_FILE:-}"
export LDAP_TLS_CIPHER_SUITE="${LDAP_TLS_CIPHER_SUITE:-HIGH:MEDIUM:!ADH}"
export LDAP_TLS_PROTOCOL_MIN="${LDAP_TLS_PROTOCOL_MIN:-3.1}"
export LDAP_ENTRYPOINT_INITDB_D_DIR="${LDAP_ENTRYPOINT_INITDB_D_DIR:-/docker-entrypoint-initdb.d}"
# Users
export LDAP_DAEMON_USER="slapd"
export LDAP_DAEMON_GROUP="slapd"
# Settings
export LDAP_PORT_NUMBER="${LDAP_PORT_NUMBER:-1389}"
export LDAP_LDAPS_PORT_NUMBER="${LDAP_LDAPS_PORT_NUMBER:-1636}"
export LDAP_ROOT="${LDAP_ROOT:-dc=example,dc=org}"
export LDAP_SUFFIX="${LDAP_SUFFIX:-$LDAP_ROOT}"
export LDAP_ADMIN_USERNAME="${LDAP_ADMIN_USERNAME:-admin}"
export LDAP_ADMIN_DN="${LDAP_ADMIN_USERNAME/#/cn=},${LDAP_ROOT}"
export LDAP_ADMIN_PASSWORD="${LDAP_ADMIN_PASSWORD:-adminpassword}"
export LDAP_CONFIG_ADMIN_ENABLED="${LDAP_CONFIG_ADMIN_ENABLED:-no}"
export LDAP_CONFIG_ADMIN_USERNAME="${LDAP_CONFIG_ADMIN_USERNAME:-admin}"
export LDAP_CONFIG_ADMIN_DN="${LDAP_CONFIG_ADMIN_USERNAME/#/cn=},cn=config"
export LDAP_CONFIG_ADMIN_PASSWORD="${LDAP_CONFIG_ADMIN_PASSWORD:-configpassword}"
export LDAP_ADD_SCHEMAS="${LDAP_ADD_SCHEMAS:-yes}"
export LDAP_EXTRA_SCHEMAS="${LDAP_EXTRA_SCHEMAS:-cosine,inetorgperson,nis}"
export LDAP_SKIP_DEFAULT_TREE="${LDAP_SKIP_DEFAULT_TREE:-no}"
export LDAP_USERS="${LDAP_USERS:-user01,user02}"
export LDAP_PASSWORDS="${LDAP_PASSWORDS:-pa55word1,pa55word2}"
export LDAP_USER_DC="${LDAP_USER_DC:-users}"
export LDAP_GROUP_DC="${LDAP_GROUP_DC:-groups}"
export LDAP_GROUP="${LDAP_GROUP:-readers}"
export LDAP_ENABLE_TLS="${LDAP_ENABLE_TLS:-no}"
export LDAP_REQUIRE_TLS="${LDAP_REQUIRE_TLS:-no}"
export LDAP_ULIMIT_NOFILES="${LDAP_ULIMIT_NOFILES:-1024}"
export LDAP_ALLOW_ANON_BINDING="${LDAP_ALLOW_ANON_BINDING:-yes}"
export LDAP_LOGLEVEL="${LDAP_LOGLEVEL:-32768}"
export LDAP_PASSWORD_HASH="${LDAP_PASSWORD_HASH:-{SSHA\}}"
export LDAP_ARGON2_MODULE_LOAD_ARGUMENTS=""
export LDAP_CONFIGURE_PPOLICY="${LDAP_CONFIGURE_PPOLICY:-no}"
export LDAP_PPOLICY_USE_LOCKOUT="${LDAP_PPOLICY_USE_LOCKOUT:-no}"
export LDAP_PPOLICY_HASH_CLEARTEXT="${LDAP_PPOLICY_HASH_CLEARTEXT:-no}"
export LDAP_ENABLE_LOAD_BALANCER="${LDAP_ENABLE_LOAD_BALANCER:-no}"
export LDAP_ENABLE_ACCESSLOG="${LDAP_ENABLE_ACCESSLOG:-yes}"
export LDAP_ACCESSLOG_DB="${LDAP_ACCESSLOG_DB:-cn=accesslog}"
export LDAP_ACCESSLOG_LOGOPS="${LDAP_ACCESSLOG_LOGOPS:-writes}"
export LDAP_ACCESSLOG_LOGSUCCESS="${LDAP_ACCESSLOG_LOGSUCCESS:-TRUE}"
export LDAP_ACCESSLOG_LOGPURGE="${LDAP_ACCESSLOG_LOGPURGE:-07+00:00 01+00:00}"
export LDAP_ACCESSLOG_LOGOLD="${LDAP_ACCESSLOG_LOGOLD:-(objectClass=*)}"
export LDAP_ACCESSLOG_LOGOLDATTR="${LDAP_ACCESSLOG_LOGOLDATTR:-objectClass}"
export LDAP_ACCESSLOG_ADMIN_USERNAME="${LDAP_ACCESSLOG_ADMIN_USERNAME:-admin}"
export LDAP_ACCESSLOG_ADMIN_DN="${LDAP_ACCESSLOG_ADMIN_USERNAME/#/cn=},${LDAP_ACCESSLOG_DB:-cn=accesslog}"
export LDAP_ACCESSLOG_ADMIN_PASSWORD="${LDAP_ACCESSLOG_PASSWORD:-accesspassword}"
export LDAP_ENABLE_SYNCPROV="${LDAP_ENABLE_SYNCPROV:-no}"
export LDAP_SYNCPROV_CHECKPOINT="${LDAP_SYNCPROV_CHECKPOINT:-100 10}"
export LDAP_SYNCPROV_SESSIONLOG="${LDAP_SYNCPROV_SESSIONLOG:-100}"

# By setting an environment variable matching *_FILE to a file path, the prefixed environment
# variable will be overridden with the value specified in that file
ldap_env_vars=(
    LDAP_ADMIN_PASSWORD
    LDAP_CONFIG_ADMIN_PASSWORD
    LDAP_ACCESSLOG_ADMIN_PASSWORD
)
for env_var in "${ldap_env_vars[@]}"; do
    file_env_var="${env_var}_FILE"
    if [[ -n "${!file_env_var:-}" ]]; then
        if [[ -r "${!file_env_var:-}" ]]; then
            export "${env_var}=$(< "${!file_env_var}")"
            unset "${file_env_var}"
        else
            warn "Skipping export of '${env_var}'. '${!file_env_var:-}' is not readable."
        fi
    fi
done
unset ldap_env_vars

# Setting encrypted admin passwords
export LDAP_ENCRYPTED_ADMIN_PASSWORD="$(echo -n $LDAP_ADMIN_PASSWORD | slappasswd -n -T /dev/stdin)"
export LDAP_ENCRYPTED_CONFIG_ADMIN_PASSWORD="$(echo -n $LDAP_CONFIG_ADMIN_PASSWORD | slappasswd -n -T /dev/stdin)"
export LDAP_ENCRYPTED_ACCESSLOG_ADMIN_PASSWORD="$(echo -n $LDAP_ACCESSLOG_ADMIN_PASSWORD | slappasswd -n -T /dev/stdin)"

# Set of directories we should examine for ownership and permisssions
ldap_expected_directories=(
    LDAP_DATA_DIR
    LDAP_ENTRYPOINT_INITDB_D_DIR
    LDAP_ONLINE_CONF_DIR
    LDAP_SHARE_DIR
    LDAP_VAR_DIR
)

# Non-root users can't create domain sockets in /var/run, but they can in /tmp
# The ldapi: URI scheme is defined in RFC 2255. Paths must be URL encoded,
# so "/" becomes "%2F".  The absence of a path, a URI of "ldap:///" will
# create the socket in /var/run (a symbolic link to /run).
if am_i_root; then
   ldapi_path="/"
else
   ldapi_path="%2Ftmp%2Fldapi"
fi
export LDAP_LDAPI_URI="ldapi://${ldapi_path}"

EOF
}

if is_boolean_yes "${SYMAS_DEBUG:-false}" ; then
    # LDAP_LOGLEVEL is unset at this time except by the user because
    # this code executes before the first call to ldap_env().
    if [ "${LDAP_LOGLEVEL:-}X" = "X" ]; then
        # If not set by the user, and they want debugging, then enable
        # all debugging output posssible.
        export LDAP_LOGLEVEL=-1
        slapd_debug_args=("-d" "-1")
    else
        slapd_debug_args=("-d" "${LDAP_LOGLEVEL}")
    fi
else
    slapd_debug_args=()
fi


########################
# Validate settings in LDAP_* environment variables
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_validate() {
    info "Validating settings in LDAP_* env vars"
    local error_code=0

    # Auxiliary functions
    print_validation_error() {
        error "$1"
        error_code=1
    }
    for var in LDAP_SKIP_DEFAULT_TREE LDAP_ENABLE_TLS; do
        if ! is_yes_no_value "${!var}"; then
            print_validation_error "The allowed values for $var are: yes or no"
        fi
    done

    if is_boolean_yes "$LDAP_ENABLE_TLS"; then
        if [[ -z "$LDAP_TLS_CERT_FILE" ]]; then
            print_validation_error "You must provide a X.509 certificate in order to use TLS"
        elif [[ ! -f "$LDAP_TLS_CERT_FILE" ]]; then
            print_validation_error "The X.509 certificate file in the specified path ${LDAP_TLS_CERT_FILE} does not exist"
        fi
        if [[ -z "$LDAP_TLS_KEY_FILE" ]]; then
            print_validation_error "You must provide a private key in order to use TLS"
        elif [[ ! -f "$LDAP_TLS_KEY_FILE" ]]; then
            print_validation_error "The private key file in the specified path ${LDAP_TLS_KEY_FILE} does not exist"
        fi
        if [[ -z "$LDAP_TLS_CA_FILE" ]]; then
            print_validation_error "You must provide a CA X.509 certificate in order to use TLS"
        elif [[ ! -f "$LDAP_TLS_CA_FILE" ]]; then
            print_validation_error "The CA X.509 certificate file in the specified path ${LDAP_TLS_CA_FILE} does not exist"
        fi
    fi

    read -r -a users <<< "$(tr ',;' ' ' <<< "${LDAP_USERS}")"
    read -r -a passwords <<< "$(tr ',;' ' ' <<< "${LDAP_PASSWORDS}")"
    if [[ "${#users[@]}" -ne "${#passwords[@]}" ]]; then
        print_validation_error "Specify the same number of passwords on LDAP_PASSWORDS as the number of users on LDAP_USERS!"
    fi

    if [[ -n "$LDAP_PORT_NUMBER" ]] && [[ -n "$LDAP_LDAPS_PORT_NUMBER" ]]; then
        if [[ "$LDAP_PORT_NUMBER" -eq "$LDAP_LDAPS_PORT_NUMBER" ]]; then
            print_validation_error "LDAP_PORT_NUMBER and LDAP_LDAPS_PORT_NUMBER are bound to the same port!"
        fi
    fi

    [[ "$error_code" -eq 0 ]] || exit "$error_code"
}

########################
# Check if OpenLDAP is running
# Globals:
#   LDAP_PID_FILE
# Arguments:
#   None
# Returns:
#   Whether slapd is running
#########################
is_ldap_running() {
    local pid
    pid="$(get_pid_from_file "${LDAP_PID_FILE}")"
    if [[ -n "${pid}" ]]; then
        is_service_running "${pid}"
    else
        return 1
    fi
}

########################
# Check if OpenLDAP is not running
# Arguments:
#   None
# Returns:
#   Whether slapd is not running
#########################
is_ldap_not_running() {
    ! is_ldap_running
}

########################
# Start OpenLDAP server in background
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_start_bg() {
    local -r retries="${1:-12}"
    local -r sleep_time="${2:-1}"
    local -a flags=("-h" "${LDAP_LDAPI_URI} " "-F" "${LDAP_CONF_DIR}/slapd.d" "-d" "$LDAP_LOGLEVEL")

    if [ $# -eq 3 ]; then
        flags+=("-f" "$3")
    fi
    if is_ldap_not_running; then
        info "Starting OpenLDAP server in background"
        ensure_dir_exists $(dirname "$LDAP_PID_FILE") ${LDAP_DAEMON_USER} ${LDAP_DAEMON_GROUP}
        ulimit -n "$LDAP_ULIMIT_NOFILES"
        am_i_root && flags=("-u" "$LDAP_DAEMON_USER" "${flags[@]}")
        debug_execute slapd "${flags[@]}" &
        if ! retry_while is_ldap_running "$retries" "$sleep_time"; then
            error "OpenLDAP failed to start"
            return 1
        fi
    fi
}

########################
# Stop OpenLDAP server
# Arguments:
#   $1 - max retries. Default: 12
#   $2 - sleep between retries (in seconds). Default: 1
# Returns:
#   None
#########################
ldap_stop() {
    local -r retries="${1:-12}"
    local -r sleep_time="${2:-1}"

    are_db_files_locked() {
        local return_value=0
        read -r -a db_files <<< "$(find "$LDAP_DATA_DIR" -type f -print0 | xargs -0)"
        for f in "${db_files[@]}"; do
            result=$(fuser "$f" 2>&1)
            pid=$(echo $result | cut -d ':' -f 2-)
            if [ -n "$pid" ]; then
                if is_boolean_yes "${SYMAS_DEBUG:-false}" ; then
                    process=$(ps -p $"pid" -o comm=)
                    warn "ldap_stop waiting on ${process} to close ${f} file"
                fi
                return_value=1
            fi
        done
        return "$return_value"
    }

    is_ldap_not_running && return

    stop_service_using_pid "${LDAP_PID_FILE}"
    if ! retry_while are_db_files_locked "$retries" "$sleep_time"; then
        error "OpenLDAP failed to stop"
        return 1
    fi
}

########################
# Create slapd.ldif
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_create_slapd_file() {
    info "Creating slapd.ldif"
    cat > "${LDAP_SHARE_DIR}/slapd.ldif" << EOF
#
# See slapd-config(5) for details on configuration options.
# This file should NOT be world readable.
#

dn: cn=config
objectClass: olcGlobal
cn: config
olcArgsFile: ${LDAP_ARGS_FILE}
olcPidFile: ${LDAP_PID_FILE}

#
# Load dynamic backend modules commonly compiled in and available by default:
#

dn: cn=module,cn=config
objectClass: olcModuleList
cn: module
olcModulePath: ${LDAP_BASE_DIR}/lib/openldap
olcModuleLoad: back_mdb.la

#
# Schema settings
#

dn: cn=schema,cn=config
objectClass: olcSchemaConfig
cn: schema

include: file://${LDAP_BASE_DIR}/etc/schema/core.ldif

#
# Frontend settings
#

dn: olcDatabase=frontend,cn=config
objectClass: olcDatabaseConfig
objectClass: olcFrontendConfig
olcDatabase: frontend

#
# Configuration database
#

dn: olcDatabase=config,cn=config
objectClass: olcDatabaseConfig
olcDatabase: config
olcAccess: to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" manage by * none

#
# Server status monitoring
#

dn: olcDatabase=monitor,cn=config
objectClass: olcDatabaseConfig
olcDatabase: monitor
olcAccess: to * by dn.base="gidNumber=0+uidNumber=0,cn=peercred,cn=external,cn=auth" read by dn.base="cn=Manager,${LDAP_ROOT}" read by * none

#
# Backend database definitions
#

dn: olcDatabase=mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: mdb
olcDbMaxSize: 1073741824
olcSuffix: ${LDAP_ROOT}
olcRootDN: cn=Manager,${LDAP_ROOT}
olcMonitoring: FALSE
olcDbDirectory: ${LDAP_BACKEND_DATA_DIR}
olcDbIndex: objectClass eq,pres
olcDbIndex: ou,cn,mail,surname,givenname eq,pres,sub

EOF

}

########################
# Create LDAP online configuration
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_create_online_configuration() {
    info "Creating LDAP online configuration"
    ldap_create_slapd_file
    if ! am_i_root; then
        replace_in_file "${LDAP_SHARE_DIR}/slapd.ldif" "uidNumber=0" "uidNumber=$(id -u)"
        replace_in_file "${LDAP_SHARE_DIR}/slapd.ldif" "gidNumber=0" "gidNumber=$(id -g)"
    fi
}

########################
# Configure LDAP credentials for admin user
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_admin_credentials() {
    info "Configure LDAP credentials for admin user"
    cat > "${LDAP_SHARE_DIR}/admin.ldif" << EOF
dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcSuffix
olcSuffix: ${LDAP_SUFFIX}

dn: olcDatabase={2}mdb,cn=config
changetype: modify
replace: olcRootDN
olcRootDN: ${LDAP_ADMIN_DN}

dn: olcDatabase={2}mdb,cn=config
changeType: modify
add: olcRootPW
olcRootPW: ${LDAP_ENCRYPTED_ADMIN_PASSWORD}

dn: olcDatabase={1}monitor,cn=config
changetype: modify
replace: olcAccess
olcAccess: {0}to * by dn.base="gidNumber=$(id -g)+uidNumber=$(id -u),cn=peercred,cn=external, cn=auth" read by dn.base="${LDAP_ADMIN_DN}" read by * none
EOF
    if is_boolean_yes "$LDAP_CONFIG_ADMIN_ENABLED"; then
        cat >> "${LDAP_SHARE_DIR}/admin.ldif" << EOF

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootDN
olcRootDN: $LDAP_CONFIG_ADMIN_DN

dn: olcDatabase={0}config,cn=config
changetype: modify
add: olcRootPW
olcRootPW: $LDAP_ENCRYPTED_CONFIG_ADMIN_PASSWORD
EOF
    fi
    ldapmodify_ldif "${LDAP_SHARE_DIR}/admin.ldif" -Y EXTERNAL
}

########################
# Disable LDAP anonymous bindings
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_disable_anon_binding() {
    info "Disable LDAP anonymous binding"
    cat > "${LDAP_SHARE_DIR}/disable_anon_bind.ldif" << EOF
dn: cn=config
changetype: modify
add: olcDisallows
olcDisallows: bind_anon

dn: cn=config
changetype: modify
add: olcRequires
olcRequires: authc
EOF
    ldapmodify_ldif "${LDAP_SHARE_DIR}/disable_anon_bind.ldif" -Y EXTERNAL
}


########################
# Configure syslog format for debug log output
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_syslog_log_format() {
    info "Enable Syslog/UTC log output"
    cat > "${LDAP_SHARE_DIR}/enable_syslog_format.ldif" << EOF

dn: cn=config
changetype: modify
replace: olcLogFileFormat
olcLogFileFormat: syslog-utc

dn: cn=config
changetype: modify
replace: olcLogFile
olcLogFile: /dev/fd/2

dn: cn=config
changetype: modify
replace: olcLogFileOnly
olcLogFileOnly: TRUE
EOF
    ldapmodify_ldif "${LDAP_SHARE_DIR}/enable_syslog_format.ldif" -Y EXTERNAL
}

########################
# Add LDAP schemas
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns
#   None
#########################
ldap_add_schemas() {
    info "Adding extra schemas ${LDAP_EXTRA_SCHEMAS} ..."
    read -r -a schemas <<< "$(tr ',;' ' ' <<< "${LDAP_EXTRA_SCHEMAS}")"
    for schema in "${schemas[@]}"; do
        info "\t${LDAP_CONF_DIR}/schema/${schema}.ldif"
        if [ ! -f "${LDAP_CONF_DIR}/schema/${schema}.ldif" ]; then
            error "Extra schema ${schema} does not exist at ${LDAP_CONF_DIR}/schema/${schema}.ldif"
        fi
        ldapadd_ldif "${LDAP_CONF_DIR}/schema/${schema}.ldif" -Y EXTERNAL
    done
}

########################
# Add custom schema
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns
#   None
#########################
ldap_add_custom_schema() {
    info "Adding custom schema from ${LDAP_CUSTOM_SCHEMA_FILE} ..."
    ldapadd_ldif "${LDAP_CUSTOM_SCHEMA_FILE}" -Y EXTERNAL
}

########################
# Add custom schemas
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns
#   None
#########################
ldap_add_custom_schemas() {
    info "Adding custom schemas in ${LDAP_CUSTOM_SCHEMA_DIR} ..."
    for schema in $(find "$LDAP_CUSTOM_SCHEMA_DIR" -maxdepth 1 \( -type f -o -type l \) -iname '*.ldif' -print | sort); do
        info "\t${schema}"
        ldapadd_ldif "${schema}" -Y EXTERNAL
    done
}

########################
# Create LDAP tree
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_create_tree() {
    info "Creating LDAP default tree"
    local dc=""
    local o="example"
    read -r -a root <<< "$(tr ',;' ' ' <<< "${LDAP_ROOT}")"
    for attr in "${root[@]}"; do
        if [[ $attr = dc=* ]] && [[ -z "$dc" ]]; then
            dc="${attr:3}"
        elif [[ $attr = o=* ]] && [[ $o = "example" ]]; then
            o="${attr:2}"
        fi
    done
    cat > "${LDAP_SHARE_DIR}/tree.ldif" << EOF
# Root creation
dn: $LDAP_ROOT
objectClass: dcObject
objectClass: organization
dc: $dc
o: $o

dn: ${LDAP_USER_DC/#/ou=},${LDAP_ROOT}
objectClass: organizationalUnit
ou: users

dn: ${LDAP_GROUP_DC/#/ou=},${LDAP_ROOT}
objectClass: organizationalUnit
ou: users

EOF
    read -r -a users <<< "$(tr ',;' ' ' <<< "${LDAP_USERS}")"
    read -r -a passwords <<< "$(tr ',;' ' ' <<< "${LDAP_PASSWORDS}")"
    local index=0
    for user in "${users[@]}"; do
        cat >> "${LDAP_SHARE_DIR}/tree.ldif" << EOF
# User $user creation
dn: ${user/#/cn=},${LDAP_USER_DC/#/ou=},${LDAP_ROOT}
cn: User$((index + 1 ))
sn: Bar$((index + 1 ))
objectClass: inetOrgPerson
objectClass: posixAccount
objectClass: shadowAccount
userPassword: ${passwords[$index]}
uid: $user
uidNumber: $((index + 1000 ))
gidNumber: $((index + 1000 ))
homeDirectory: /home/${user}

EOF
        index=$((index + 1 ))
    done
    cat >> "${LDAP_SHARE_DIR}/tree.ldif" << EOF
# Group creation
dn: ${LDAP_GROUP/#/cn=},${LDAP_GROUP_DC/#/ou=},${LDAP_ROOT}
cn: $LDAP_GROUP
objectClass: groupOfNames
# User group membership
EOF

    for user in "${users[@]}"; do
        cat >> "${LDAP_SHARE_DIR}/tree.ldif" << EOF
member: ${user/#/cn=},${LDAP_USER_DC/#/ou=},${LDAP_ROOT}
EOF
    done

    ldapadd_ldif "${LDAP_SHARE_DIR}/tree.ldif" -D "${LDAP_ADMIN_DN}" -w "${LDAP_ADMIN_PASSWORD}"
}

########################
# Add custom LDIF files
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns
#   None
#########################
ldap_add_custom_ldifs() {
    info "Loading custom LDIF files..."
    for ldif in $(find "${LDAP_CUSTOM_LDIF_DIR}" -maxdepth 1 \( -type f -o -type l \) -iname '*.ldif' -print | sort); do
        info "\t${ldif}"
        ldapadd_ldif "${ldif}" -D "${LDAP_ADMIN_DN}" -w "${LDAP_ADMIN_PASSWORD}"
    done
}

########################
# OpenLDAP configure permissions
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_configure_permissions() {
  debug "Ensuring expected directories/files exist..."
  for expected in "${ldap_expected_directories[@]}"; do
      path="$(printenv $expected)"
      ensure_dir_exists "$path"
      if am_i_root; then
          chmod -R g+rwX "$path"
          chown -R "$LDAP_DAEMON_USER:$LDAP_DAEMON_GROUP" "$path"
          info "Ensuring ${expected}=$path is $LDAP_DAEMON_USER:$LDAP_DAEMON_GROUP and 0775/drwxrwxr-x/g+rwX recursively"
      fi
  done
}

########################
# Initialize OpenLDAP server
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_initialize() {
    info "Initializing OpenLDAP..."

    ldap_configure_permissions
    if ! are_dirs_empty "${LDAP_DATA_DIR}" "${LDAP_ONLINE_CONF_DIR}"; then
        info "Preserving existing config and data in..."
        if is_boolean_yes "${SYMAS_DEBUG}"; then
            if ! is_dir_empty "${LDAP_DATA_DIR}"; then
                info "\t${LDAP_DATA_DIR}"
                find "${LDAP_DATA_DIR}"
            fi
            if ! is_dir_empty "${LDAP_ONLINE_CONF_DIR}"; then
                info "\t${LDAP_ONLINE_CONF_DIR}"
                find "${LDAP_ONLINE_CONF_DIR}"
            fi
        fi
        return 0
    fi
    info "Setting up ${LDAP_VOLUME_DIR}/{data,slapd.d} config and data."
    ensure_dir_exists "${LDAP_ONLINE_CONF_DIR}"
    ensure_dir_exists "${LDAP_DATA_DIR}"
    ensure_dir_exists "${LDAP_BACKEND_DATA_DIR}"

    # Configure OpenLDAP
    if [ -f "${LDAP_STATIC_CONF_FILE:-}" ]; then
        # User provided static configuration
        info "Using provided static configuration in ${LDAP_STATIC_CONF_FILE}"
        ldap_start_bg 12 1 "${LDAP_STATIC_CONF_FILE}"
    else
        # Starting asisted configuration from environment variables, etc.
        info "Enabled assisted configuration"
        ldap_create_online_configuration
        slapadd_ldif "${LDAP_SHARE_DIR}/slapd.ldif"
        ldap_start_bg

        if is_boolean_yes "$LDAP_SYSLOG_LOG_FORMAT"; then
            ldap_syslog_log_format
        fi
        ldap_admin_credentials
        info "Setting up optional config..."
        if ! is_boolean_yes "$LDAP_ALLOW_ANON_BINDING"; then
            ldap_disable_anon_binding
        fi
        if is_boolean_yes "$LDAP_ENABLE_TLS"; then
            ldap_configure_tls
        fi
        # Initialize OpenLDAP with schemas/tree structure
        if is_boolean_yes "$LDAP_ADD_SCHEMAS"; then
            ldap_add_schemas
        fi
        if [[ -f "$LDAP_CUSTOM_SCHEMA_FILE" ]]; then
            ldap_add_custom_schema
        fi
        if ! is_dir_empty "$LDAP_CUSTOM_SCHEMA_DIR"; then
            ldap_add_custom_schemas
        fi
        # additional configuration
        if ! [[ "$LDAP_PASSWORD_HASH" == "{SSHA}" ]]; then
            ldap_configure_password_hash
        fi
        if is_boolean_yes "$LDAP_CONFIGURE_PPOLICY"; then
            ldap_configure_ppolicy
        fi
        # enable accesslog overlay
        if is_boolean_yes "$LDAP_ENABLE_ACCESSLOG"; then
            ldap_enable_accesslog
        fi
        # enable load balancer overlay
        if is_boolean_yes "$LDAP_ENABLE_LOAD_BALANCER"; then
            ldap_enable_load_balancer
        fi
        # enable syncprov overlay
        if is_boolean_yes "$LDAP_ENABLE_SYNCPROV"; then
            ldap_enable_syncprov
        fi
        # enable tls
        if is_boolean_yes "$LDAP_ENABLE_TLS"; then
            ldap_configure_tls
            if is_boolean_yes "$LDAP_REQUIRE_TLS"; then
                ldap_configure_tls_required
            fi
        fi
        if ! is_dir_empty "$LDAP_CUSTOM_LDIF_DIR"; then
            ldap_add_custom_ldifs
        elif ! is_boolean_yes "$LDAP_SKIP_DEFAULT_TREE"; then
            ldap_create_tree
        else
            info "Skipping default schemas/tree structure"
        fi
        info "OpenLDAP configuration and databases are now configured for service."
    fi
    ldap_stop; while is_ldap_running; do sleep 1; done
}

########################
# Run custom initialization scripts
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_custom_init_scripts() {
    if is_dir_empty "${LDAP_ENTRYPOINT_INITDB_D_DIR}"; then
        debug "\tnone found"
        return 0
    fi
    read -r -a config_files <<< "$(find "${LDAP_ENTRYPOINT_INITDB_D_DIR}"/ -maxdepth 1 -type f -print0 | xargs -0)"
    readarray -t config_files < <(printf '%s\0' "${config_files[@]}" | sort -z | xargs -0n1)
    for f in "${config_files[@]}"; do
        ret_code=-1
        case "$f" in
            *modify*.ldif)
                info "\tslapmodify $f"
                slapmodify_ldif "$f"
                ret_code=$?
                if [[ $ret_code -ne 0 ]]; then
                    error "failed loading $f ($ret_code)"
                    return 1
                fi
                ;;
            *add*.ldif|*.ldif)
                info "\tslapadd $f"
                slapadd_ldif "$f"
                ret_code=$?
                if [[ $ret_code -ne 0 ]]; then
                    error "failed loading $f ($ret_code)"
                    return 1
                fi
                ;;
            *.sh)
                if [[ -x "$f" ]]; then
                    info "\texecuting $f"
                    if is_boolean_yes "${SYMAS_DEBUG_SETUP:-}"; then
                        bash -x "$f"
                        ret_code=$?
                    else
                        bash "$f"
                        ret_code=$?
                    fi
                    if [[ $ret_code -ne 0 ]]; then
                        error "failed executing $f ($ret_code)"
                        return 1
                    fi
                elif [[ -O "$f" ]]; then
                    info "\tsourcing $f"
                    source "$f"
                else
                    warn "\tskipping $f because it is not owned by current user ($(id -u)/$(whoami)) and not executable"
                fi
                ;;
            *)
                if [[ -x "$f" ]]; then
                    info "\texecuting $f"
                    exec "$f"
                    ret_code=$?
                    if [[ $ret_code -ne 0 ]]; then
                        error "failed executing $f ($ret_code)"
                        return 1
                    fi
                else
                    warn "\tskipping $f, not executable or Bash shell (.sh) script"
                fi
                ;;
        esac
    done
}

########################
# OpenLDAP configure TLS
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_configure_tls() {
    info "Configuring TLS"
    cat > "${LDAP_SHARE_DIR}/certs.ldif" << EOF
dn: cn=config
changetype: modify
replace: olcTLSCACertificateFile
olcTLSCACertificateFile: $LDAP_TLS_CA_FILE
-
replace: olcTLSCertificateFile
olcTLSCertificateFile: $LDAP_TLS_CERT_FILE
-
replace: olcTLSCertificateKeyFile
olcTLSCertificateKeyFile: $LDAP_TLS_KEY_FILE
-
replace: olcTLSCipherSuite
olcTLSCipherSuite: $LDAP_TLS_CIPHER_SUITE
-
replace: olcTLSProtocolMin
olcTLSProtocolMin: $LDAP_TLS_PROTOCOL_MIN
-
replace: olcTLSVerifyClient
olcTLSVerifyClient: $LDAP_TLS_VERIFY_CLIENTS
EOF
    if [[ -f "$LDAP_TLS_DH_PARAMS_FILE" ]]; then
        cat >> "${LDAP_SHARE_DIR}/certs.ldif" << EOF
-
replace: olcTLSDHParamFile
olcTLSDHParamFile: $LDAP_TLS_DH_PARAMS_FILE
EOF
    fi
    ldapmodify_ldif "${LDAP_SHARE_DIR}/certs.ldif" -Y EXTERNAL
}

########################
# OpenLDAP configure connections to require TLS
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_configure_tls_required() {
    info "Configuring LDAP connections to require TLS"
    cat > "${LDAP_SHARE_DIR}/tls_required.ldif" << EOF
dn: cn=config
changetype: modify
add: olcSecurity
olcSecurity: tls=1
EOF
    ldapmodify_ldif "${LDAP_SHARE_DIR}/tls_required.ldif" -Y EXTERNAL
}

########################
# OpenLDAP enable module
# Globals:
#   LDAP_*
# Arguments:
#   $1: Module path
#   $2: Module file name
#   $3: Any additional arguments to pass in while loading the module
# Returns:
#   None
#########################
ldap_load_module() {
    info "Loading module $1/$2"
    cat > "${LDAP_SHARE_DIR}/enable_module_$2.ldif" << EOF
dn: cn=module,cn=config
cn: module
objectClass: olcModuleList
olcModulePath: $1
olcModuleLoad: $2 ${3:-}
EOF

    if is_ldap_running; then
        ldapadd_ldif "${LDAP_SHARE_DIR}/enable_module_${2}.ldif" -Y EXTERNAL
    else
        slapadd_ldif "${LDAP_SHARE_DIR}/enable_module_${2}.ldif" "${LDAP_ONLINE_CONF_DIR}"
    fi
}

########################
# OpenLDAP configure ppolicy
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_configure_ppolicy() {
    info "Configuring LDAP ppolicy"
    ldap_load_module "${LDAP_BASE_DIR}/lib/openldap" "ppolicy.so"
    # create configuration
    cat > "${LDAP_SHARE_DIR}/ppolicy_create_configuration.ldif" << EOF
dn: olcOverlay={0}ppolicy,olcDatabase={2}mdb,cn=config
objectClass: olcOverlayConfig
objectClass: olcPPolicyConfig
olcOverlay: {0}ppolicy
EOF
    ldapadd_ldif "${LDAP_SHARE_DIR}/ppolicy_create_configuration.ldif" -Q -Y EXTERNAL
    # enable ppolicy_hash_cleartext
    if is_boolean_yes "$LDAP_PPOLICY_HASH_CLEARTEXT"; then
        info "Enabling ppolicy_hash_cleartext"
        cat > "${LDAP_SHARE_DIR}/ppolicy_configuration_hash_cleartext.ldif" << EOF
dn: olcOverlay={0}ppolicy,olcDatabase={2}mdb,cn=config
changetype: modify
add: olcPPolicyHashCleartext
olcPPolicyHashCleartext: TRUE
EOF
    ldapmodify_ldif "${LDAP_SHARE_DIR}/ppolicy_configuration_hash_cleartext.ldif" -Q -Y EXTERNAL
    fi
    # enable ppolicy_use_lockout
    if is_boolean_yes "$LDAP_PPOLICY_USE_LOCKOUT"; then
        info "Enabling ppolicy_use_lockout"
        cat > "${LDAP_SHARE_DIR}/ppolicy_configuration_use_lockout.ldif" << EOF
dn: olcOverlay={0}ppolicy,olcDatabase={2}mdb,cn=config
changetype: modify
add: olcPPolicyUseLockout
olcPPolicyUseLockout: TRUE
EOF
        ldapmodify_ldif "${LDAP_SHARE_DIR}/ppolicy_configuration_use_lockout.ldif" -Q -Y EXTERNAL
    fi
}

########################
# OpenLDAP configure olcPasswordHash
# Globals:
#   LDAP_SHARE_DIR, LDAP_CRYPT_SALT_FORMAT
#   LDAP_PASSWORD_HASH: {SSHA}, {SHA}, {SMD5}, {MD5}, {CRYPT}, or  {CLEARTEXT}
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_configure_password_hash() {
    info "Configuring LDAP olcPasswordHash: ${LDAP_PASSWORD_HASH}"

    cat > "${LDAP_SHARE_DIR}/password_hash.ldif" << EOF
dn: olcDatabase={-1}frontend,cn=config
changetype: modify
add: olcPasswordHash
EOF
    case "${LDAP_PASSWORD_HASH}" in
        "{ARGON2}")
            ldap_load_module "${LDAP_BASE_DIR}/lib/openldap" "argon2" "${LDAP_ARGON2_MODULE_LOAD_ARGUMENTS}"
            cat >> "${LDAP_SHARE_DIR}/password_hash.ldif" << EOF
olcPasswordHash: ${LDAP_PASSWORD_HASH}
EOF
            ;;
        "{CRYPT}")
            cat >> "${LDAP_SHARE_DIR}/password_hash.ldif" << EOF
olcPasswordHash: ${LDAP_PASSWORD_HASH}
olcPasswordCryptSaltFormat: ${LDAP_CRYPT_SALT_FORMAT:-$y$.16s}
EOF
            ;;
        "{SHA256}"|"{SHA384}"|"{SHA512}"|"{SSHA256}"|"{SSHA384}"|"{SSHA512}")
            ldap_load_module "${LDAP_BASE_DIR}/lib/openldap" "pw-sha2"
            cat >> "${LDAP_SHARE_DIR}/password_hash.ldif" << EOF
olcPasswordHash: ${LDAP_PASSWORD_HASH}
EOF
            ;;
        *)
            cat >> "${LDAP_SHARE_DIR}/password_hash.ldif" << EOF
olcPasswordHash: ${LDAP_PASSWORD_HASH}
EOF
            ;;
    esac
    ldapmodify_ldif "${LDAP_SHARE_DIR}/password_hash.ldif" -Y EXTERNAL
}

########################
# OpenLDAP index Access Logging
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_index_accesslog() {
    if ! [[ -f "${LDAP_SHARE_DIR}/accesslog_add_indexes.ldif" ]]; then
        info "Configure Access Log Indexes"
        cat > "${LDAP_SHARE_DIR}/accesslog_add_indexes.ldif" << EOF
dn: olcDatabase={2}mdb,cn=config
changetype: modify
add: olcDbIndex
olcDbIndex: entryCSN eq
-
add: olcDbIndex
olcDbIndex: entryUUID eq
EOF
        ldapmodify_ldif "${LDAP_SHARE_DIR}/accesslog_add_indexes.ldif" -Y EXTERNAL
    fi
}

########################
# OpenLDAP configure Access Logging
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_enable_accesslog() {
    info "Configure Access Logging"
    ldap_index_accesslog
    # Load module
    ldap_load_module "${LDAP_BASE_DIR}/lib/openldap" "accesslog"
    # Create AccessLog database
    cat > "${LDAP_SHARE_DIR}/accesslog_create_accesslog_database.ldif" << EOF
dn: olcDatabase={3}mdb,cn=config
objectClass: olcDatabaseConfig
objectClass: olcMdbConfig
olcDatabase: {3}mdb
olcDbDirectory: $LDAP_ACCESSLOG_DATA_DIR
olcSuffix: $LDAP_ACCESSLOG_DB
olcRootDN: $LDAP_ACCESSLOG_ADMIN_DN
olcRootPW: $LDAP_ENCRYPTED_ACCESSLOG_ADMIN_PASSWORD
olcDbIndex: default eq
olcDbIndex: entryCSN,objectClass,reqEnd,reqResult,reqStart
EOF
    mkdir "${LDAP_ACCESSLOG_DATA_DIR}"
    ldapadd_ldif "${LDAP_SHARE_DIR}/accesslog_create_accesslog_database.ldif" -Q -Y EXTERNAL

    # Add AccessLog overlay
    cat > "${LDAP_SHARE_DIR}/accesslog_create_overlay_configuration.ldif" << EOF
dn: olcOverlay=accesslog,olcDatabase={2}mdb,cn=config
objectClass: olcOverlayConfig
objectClass: olcAccessLogConfig
olcOverlay: accesslog
olcAccessLogDB: $LDAP_ACCESSLOG_DB
olcAccessLogOps: $LDAP_ACCESSLOG_LOGOPS
olcAccessLogSuccess: $LDAP_ACCESSLOG_LOGSUCCESS
olcAccessLogPurge: $LDAP_ACCESSLOG_LOGPURGE
olcAccessLogOld: $LDAP_ACCESSLOG_LOGOLD
olcAccessLogOldAttr: $LDAP_ACCESSLOG_LOGOLDATTR
EOF
    info "adding accesslog_create_overlay_configuration.ldif"
    ldapadd_ldif "${LDAP_SHARE_DIR}/accesslog_create_overlay_configuration.ldif" -Q -Y EXTERNAL
}

########################
# OpenLDAP configure load balancer
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_enable_load_balancer() {
    info "Configure Load Balancer"
    # Load module
    ldap_load_module "${LDAP_BASE_DIR}/lib/openldap" "lload"
    # TODO: configure it...
}

########################
# OpenLDAP configure Sync Provider
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   None
#########################
ldap_enable_syncprov() {
    info "Configure Sync Provider"
    ldap_index_accesslog
    # Load module
    ldap_load_module "${LDAP_BASE_DIR}/lib/openldap" "syncprov"
    # Add Sync Provider overlay
    cat > "${LDAP_SHARE_DIR}/syncprov_create_overlay_configuration.ldif" << EOF
dn: olcOverlay=syncprov,olcDatabase={2}mdb,cn=config
objectClass: olcOverlayConfig
objectClass: olcSyncProvConfig
olcOverlay: syncprov
olcSpCheckpoint: ${LDAP_SYNCPROV_CHECKPOINT}
EOF
    if is_boolean_yes "${LDAP_ENABLE_ACCESSLOG}"; then
    cat >> "${LDAP_SHARE_DIR}/syncprov_create_overlay_configuration.ldif" << EOF
olcSpSessionLogSource: $LDAP_SYNCPROV_SESSIONLOG
EOF
    else
    cat >> "${LDAP_SHARE_DIR}/syncprov_create_overlay_configuration.ldif" << EOF
olcSpSessionLog: $LDAP_SYNCPROV_SESSIONLOG
EOF
fi
    ldapadd_ldif "${LDAP_SHARE_DIR}/syncprov_create_overlay_configuration.ldif" -Q -Y EXTERNAL
}

########################
# Execute slapadd with predictable arguments
# Globals:
#   LDAP_*
# Arguments:
#   The full path to an LDIF file to load
#   The config dir, defaults to LDAP_ONLINE_CONF_DIR
# Returns:
#   None
#########################
slapadd_ldif() {
    local -a flags=(-F "${2:-${LDAP_ONLINE_CONF_DIR}}" -n 0 -l "$1") # -b "${3:-cn=config}"
    if [ $# -ge 2 ]; then set -- "${@:2}"; else set -- "${@:1}"; fi
    if am_i_root; then
        debug_execute run_as_user "${LDAP_DAEMON_USER}" slapadd "${slapd_debug_args[@]}" "${flags[@]}" ${@}
    else
        debug_execute slapadd "${slapd_debug_args[@]}" "${flags[@]}"
    fi
}

########################
# Execute slapmodify with predictable arguments
# Globals:
#   LDAP_*
# Arguments:
#   The full path to an LDIF file to load
#   The config dir, defaults to LDAP_ONLINE_CONF_DIR
# Returns:
#   None
#########################
slapmodify_ldif() {
    local -a flags=(-F "${2:-${LDAP_ONLINE_CONF_DIR}}" -n 0 -l "$1") # -b "${3:-cn=config}"
    if [ $# -ge 2 ]; then set -- "${@:2}"; else set -- "${@:1}"; fi
    if am_i_root; then
        debug_execute run_as_user "${LDAP_DAEMON_USER}" slapmodify "${slapd_debug_args[@]}" "${flags[@]}" ${@}
    else
        debug_execute slapmodify "${slapd_debug_args[@]}" "${flags[@]}"
    fi
}

########################
# Execute ldapadd with predictable arguments
# Globals:
#   LDAP_*
# Arguments:
#   The full path to an LDIF file to load
# Returns:
#   None
#########################
ldapadd_ldif() {
    local -a flags=("${slapd_debug_args[@]}" -H "$LDAP_LDAPI_URI")
    debug_execute ldapadd  "${flags[@]}" -f ${@}
}

########################
# Execute ldapmodify with predictable arguments
# Globals:
#   LDAP_*
# Arguments:
#   The full path to an LDIF file to load
# Returns:
#   None
#########################
ldapmodify_ldif() {
    local -a flags=("${slapd_debug_args[@]}" -H "$LDAP_LDAPI_URI")
    debug_execute ldapmodify  "${flags[@]}" -f ${@}
}

########################
# Has we successfully finished setup before?
# Globals:
#   LDAP_*
# Arguments:
#   None
# Returns:
#   true/false
#########################
is_ldap_setup() {
    [[ -f "$LDAP_VOLUME_DIR/.ldap_setup_complete" ]] && return
    return 1
}
