#!/bin/bash
# https://www.docker.com/blog/faster-multi-platform-builds-dockerfile-cross-compilation-guide/

n=2

docker buildx build --build-arg NOW="$(date --utc +%FT%TZ)" --progress=plain --no-cache --rm --platform linux/amd64,linux/arm64/v8 -t symas/openldap:latest -t symas/openldap:2 -t symas/openldap:2.6 -t symas/openldap:2.6 -t symas/openldap:2.6.6-debian-11 -t "symas/openldap:2.6.6-debian-11-r${n}" .

for i in latest 2 2.6 2.6.6 2.6-debian-11 2.6.6-debian-11 "2.6.6-debian-11-r${n}"; do
    docker push "symas/openldap:$i"
done
