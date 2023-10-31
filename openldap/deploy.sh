#!/bin/bash
# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/

set -euo pipefail
set -x

cd 2.5/debian-11
n=3

docker buildx build --push --build-arg BUILD=$n --build-arg NOW="$(date --utc +%FT%TZ)" --progress=plain --no-cache --rm --platform linux/amd64 symas/openldap:2.5 -t symas/openldap:2.5.16 -t symas/openldap:2.5.16-debian-11 -t "symas/openldap:2.5.16-debian-11-r${n}" .

cd ../..
cd 2.6/debian-11
n=10

docker buildx build --push --build-arg BUILD=$n --build-arg NOW="$(date --utc +%FT%TZ)" --progress=plain --no-cache --rm --platform linux/amd64,linux/arm64/v8 -t symas/openldap:latest -t symas/openldap:2 -t symas/openldap:2.6 -t symas/openldap:2.6.6 -t symas/openldap:2.6.6-debian-11 -t "symas/openldap:2.6.6-debian-11-r${n}" .
