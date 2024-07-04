#!/usr/bin/env bash
# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/

set -euo pipefail
set -x

action=--load
platform=linux/amd64
#action=--push
#platform=linux/amd64,linux/arm64/v8

now="$(date --utc +%FT%TZ)"

# VERSION 2.5.x ===============================================================
cd 2.5/debian-12
n=2

docker buildx build $action \
       --build-arg BUILD=$n --build-arg NOW=${now} \
       --progress=plain --no-cache --rm \
       --platform $platform \
       -t symas/openldap:2.5 \
       -t symas/openldap:2.5.18 \
       -t "symas/openldap:2.5.18-${n}" \
       -t symas/openldap:2.5.18-debian-12 \
       -t "symas/openldap:2.5.18-debian-12-r${n}" .

# VERSION 2.6.x ===============================================================
cd ../..
cd 2.6/debian-12
n=3

docker buildx build $action \
       --build-arg BUILD=$n --build-arg NOW=${now} \
       --progress=plain --no-cache --rm \
       --platform $platform \
       -t symas/openldap:latest \
       -t symas/openldap:2 \
       -t symas/openldap:2.6 \
       -t symas/openldap:2.6.8 \
       -t "symas/openldap:2.6.8-${n}" \
       -t symas/openldap:2.6.8-debian-12 \
       -t "symas/openldap:2.6.8-debian-12-r${n}" .
