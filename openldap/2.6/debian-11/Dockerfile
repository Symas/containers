# syntax=docker/dockerfile:1

# Copyright VMware, Inc. 2003
# Copyright Symas Corp. 2003
# SPDX-License-Identifier: APACHE-2.0

FROM ${ARCH}docker.io/bitnami/minideb:bullseye

ARG TARGETARCH
ARG NOW

LABEL \
      org.opencontainers.image.base.name="docker.io/bitnami/minideb:bullseye" \
      org.opencontainers.image.created="${NOW}" \
      org.opencontainers.image.description="Application packaged by Symas Corp." \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.ref.name="2.6.6-debian-11-r57" \
      org.opencontainers.image.title="openldap" \
      org.opencontainers.image.vendor="Symas Corp." \
      org.opencontainers.image.version="2.6.6"

ENV HOME="/" \
    OS_ARCH="${TARGETARCH:-amd64}" \
    OS_FLAVOUR="debian-11" \
    OS_NAME="linux"

COPY prebuildfs /
# SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install required system packages and dependencies

# -- NOTE: the following is a perfectly fine way to package OpenLDAP, it's how
# Bitnami includes their build of that software for their containers.  This is
# here to show the differences between Bitnami and Symas containers, it's purely
# informational and intended to provide transparency.
# Again, thanks Bitnami/VMware!
# --
#
# RUN install_packages ca-certificates curl libargon2-1 libcap2-bin libcom-err2 libcrypt1 libgssapi-krb5-2 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libltdl7 libnsl2 libnss3-tools libodbc1 libperl5.32 libsasl2-2 libssl1.1 libtirpc3 libwrap0 mdbtools procps psmisc
# RUN mkdir -p /tmp/bitnami/pkg/cache/ && cd /tmp/bitnami/pkg/cache/ && \
#     COMPONENTS=( \
#       "openldap-2.6.6-1-linux-${OS_ARCH}-debian-11" \
#     ) && \
#     for COMPONENT in "${COMPONENTS[@]}"; do \
#       if [ ! -f "${COMPONENT}.tar.gz" ]; then \
#         curl -SsLf "https://downloads.bitnami.com/files/stacksmith/${COMPONENT}.tar.gz" -O ; \
#         curl -SsLf "https://downloads.bitnami.com/files/stacksmith/${COMPONENT}.tar.gz.sha256" -O ; \
#       fi && \
#       sha256sum -c "${COMPONENT}.tar.gz.sha256" && \
#       tar -zxf "${COMPONENT}.tar.gz" -C /opt/bitnami --strip-components=2 --no-same-owner --wildcards '*/files' && \
#       rm -rf "${COMPONENT}".tar.gz{,.sha256} ; \
#     done

# This also happends in Bitnami's setup.sh script, but only when it's
# run as root.
RUN groupadd --gid 1001 ${LDAP_DAEMON_GROUP:-slapd}
RUN useradd --system --gid 1001 --uid 1001 --groups root ${LDAP_DAEMON_USER:-slapd}

RUN install_packages ca-certificates curl gnupg libcap2-bin libcom-err2 libcrypt1 libkeyutils1 libltdl7 libnsl2 libnss3-tools libodbc1 libperl5.32 libtirpc3 libwrap0 mdbtools procps psmisc

# Configure the Symas Debian package repositories.
ARG DEBIAN=11 TRAIN=release VERSION=26
RUN curl -SsLf https://repo.symas.com/configs/SOLDAP/d${DEBIAN}/${TRAIN}${VERSION}.list -o /etc/apt/sources.list.d/soldap-${TRAIN}${VERSION}.list \
    && curl -SsLf https://repo.symas.com/repo/gpg/RPM-GPG-KEY-symas-com-signing-key -o /usr/share/keyrings/symas-key.asc \
    && apt-get -y update

# Install OpenLDAP, ldap-utils and ssl-tools.
RUN install_packages symas-openldap-clients symas-openldap-server

RUN apt-get autoremove --purge -y curl gnupg && \
    apt-get update && apt-get upgrade -y && \
    apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami

COPY rootfs /
RUN /opt/bitnami/scripts/openldap/postunpack.sh
ENV APP_VERSION="2.6.6" \
    BITNAMI_APP_NAME="openldap" \
    PATH="/opt/bitnami/openldap/bin:/opt/bitnami/openldap/sbin:$PATH"

EXPOSE 1389 1636

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/openldap/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/openldap/run.sh" ]
