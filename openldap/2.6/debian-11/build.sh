#!/bin/bash
# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/

n=8

docker buildx build --push --build-arg NOW="$(date --utc +%FT%TZ)" --progress=plain --no-cache --rm --platform linux/amd64,linux/arm64/v8 -t symas/openldap:latest -t symas/openldap:2 -t symas/openldap:2.6 -t symas/openldap:2.6.6 -t symas/openldap:2.6.6-debian-11 -t "symas/openldap:2.6.6-debian-11-r${n}" .
