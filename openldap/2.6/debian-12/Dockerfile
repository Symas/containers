# syntax=docker/dockerfile:1

# Copyright VMware, Inc. 2003
# Copyright Symas, Corp. 2023-2024
# SPDX-License-Identifier: APACHE-2.0

FROM docker.io/bitnami/minideb:bookworm

ARG TARGETARCH
ARG NOW BUILD

LABEL \
      org.opencontainers.image.base.name="docker.io/bitnami/minideb:bookworm" \
      org.opencontainers.image.created="${NOW}" \
      org.opencontainers.image.description="Application packaged by Symas Corp." \
      org.opencontainers.image.licenses="Apache-2.0" \
      org.opencontainers.image.ref.name="2.6.8-debian-12-r${BUILD}" \
      org.opencontainers.image.title="openldap" \
      org.opencontainers.image.vendor="Symas Corp." \
      org.opencontainers.image.version="2.6.8"

ENV HOME="/" \
    OS_ARCH="${TARGETARCH:-amd64}" \
    OS_FLAVOUR="debian-12" \
    OS_NAME="linux"

# Debian
ARG DEBIAN=12 CODENAME=bookworm

COPY prebuildfs /
SHELL ["/bin/bash", "-o", "errexit", "-o", "nounset", "-o", "pipefail", "-c"]

# Install required system packages and dependencies

# The following is also in the setup.sh script, but only when run as root.
RUN groupadd --gid 1001 ${LDAP_DAEMON_GROUP:-slapd}
RUN useradd --system --gid 1001 --uid 1001 --groups root ${LDAP_DAEMON_USER:-slapd}

RUN install_packages ca-certificates libcap2-bin libcom-err2 libcrypt1 libkeyutils1 libltdl7 libnsl2 libnss3-tools libodbc1 libperl5.36 libtirpc3 libwrap0 mdbtools procps psmisc curl

# Configure the Symas Debian package repositories.
ARG TRAIN=release VERSION=26
#RUN curl -SsLf https://repo.symas.com/configs/SOLDAP/d${DEBIAN}/${TRAIN}${VERSION}.list -o /etc/apt/sources.list.d/soldap-${TRAIN}${VERSION}.list \
RUN echo "deb [signed-by=/usr/share/keyrings/symas-key.asc] https://repo.symas.com/repo/deb/main/release${VERSION} ${CODENAME} main" | tee -a /etc/apt/sources.list.d/soldap-release${VERSION}.list \
    && curl -SsLf https://repo.symas.com/repo/gpg/RPM-GPG-KEY-symas-com-signing-key -o /usr/share/keyrings/symas-key.asc \
    && apt-get -y update

# Install OpenLDAP, ldap-utils and ssl-tools.
RUN install_packages symas-openldap-clients symas-openldap-server

# Cleanup the cruft
RUN apt-get clean && rm -rf /var/lib/apt/lists /var/cache/apt/archives
RUN chmod g+rwX /opt/bitnami
RUN find / -perm /6000 -type f -exec chmod a-s {} \; || true

COPY rootfs /
RUN /opt/bitnami/scripts/openldap/postunpack.sh
ENV APP_VERSION="2.6.8" \
    BITNAMI_APP_NAME="openldap" \
    PATH="/opt/bitnami/openldap/bin:/opt/bitnami/openldap/sbin:$PATH"

EXPOSE 1389 1636

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/openldap/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/openldap/run.sh" ]
