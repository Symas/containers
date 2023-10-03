# Supported Containers for OpenLDAP, by Symas Corp.

## What's here?

[OpenLDAP](https://openldap.org) and related software, provided by
[Symas](https://symas.com), containerized and ready for production use.


## Why use our images?

* Symas has, for over a decade, built, maintained, and commercially supported
  the OpenLDAP codebase.
* All our work on OpenLDAP has always been, and will always be open source.  We
  are a [commercial support comany](mailto:support@symas.com), here if and when
  you need us.
* We commit to promptly publish new versions of this image using our automated
  systems for every release of the software going forward.
* Our images contain the latest bug fixes and features released.
* We've based our containers on the amazing [Bitnami
  containers](https://github.com/bitnami/containers/) existing work.
* We'd like to thank them for open sourcing their work allowing the community to
  benefit.  Our shared philosophy makes us stronger.
* Because we are using the Bitnami container infrastructure and scripts this is
  a drop-in replacement for any existing use of the `bitnami/openldap`
  containers sharing the same version.
* We base our images on Bitnami's [minideb](https://github.com/bitnami/minideb)
  a minimalist Debian based container image that gives you a small base
  container image and the familiarity of a leading Linux distribution.
* TODO: We sign our images [Docker Content Trust
  (DCT)](https://docs.docker.com/engine/security/trust/content_trust/) and you
  _should_ use `DOCKER_CONTENT_TRUST=1` to verify the integrity of the images.


## Why not just contribute to Bitnami?

We may eventually merge our work into Bitnami, for now we'd like to remain agile
enoug to build for platforms they don't (yet) support, like `arm64`, and to use
supporting libraries (e.g. SASL) we've built that include fixes and features not
yet in their mainstream counterparts.

Fundamentally, we're a company that supports OpenLDAP as our primary business
model so it is important for us to own and support LXC (e.g. Docker, or
containers) as a primary channel for our supported customers.

We know that Bitnami provides excelent OpenLDAP containers, we appreciate that,
and you should feel confident using them.  We know that because we're the people
writing and maintaining the software in that container.

In any case, we'd like to thank Bitnami and recognize them for their excelent
work building the tooling around a complex and highly-configurable product like
OpenLDAP.


## Get an image

The recommended way to get any of the Symas Container Images is to pull the
prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/symas/)
but we also publish to the [GitHub Container Regristry (ghcr)](https://ghcr.io).

```console
docker pull symas/openldap
```

To use a specific version, you can pull a versioned tag.  Common tags include:
* `latest`
* `<version>` (e.g. 2.6)

```console
docker pull symas/openldap:[TAG]
```

If you wish, you can also build the image yourself by cloning this repository,
changing to the directory containing the Dockerfile and executing the `docker
build` command.

```console
git clone https://github.com/symas/containers.git
cd containers/openldap/2.6/debian-11
docker buildx build --progress=plain --no-cache --rm --platform linux/x86_64 --load -t symas/openldap:latest .
```


## Run the application using Docker Compose

The main folder of each application contains a functional `docker-compose.yml`
file. Run the application using it as shown below:

```console
curl -sSL https://raw.githubusercontent.com/symas/containers/main/symas/openldap/docker-compose.yml > docker-compose.yml
docker-compose up -d
```


## Vulnerability scan in Symas container images

Symas analyzes containers we ship for the presence of identifiable security
vulnerabilities as part of the release process.  Specifically, we use two
different tools:

* [Trivy](https://github.com/aquasecurity/trivy)
* [Grype](https://github.com/anchore/grype)

GitHub Actions in the CI/CD pipeline trigger this scanners for every PR
affecting the source code of the containers, regardless of its nature or origin.


## Retention policy

We retain ([Symas DockerHub org](https://hub.docker.com/u/symas)) deprecated
assets without changes for, at least, three months after the deprecation.

We may violate this policy to remove dangerous or otherwise particularily flawed
containers for the safety of the community.


## Contributing

We'd love for you to contribute to those container images. You can request new
features by creating an
[issue](https://github.com/symas/containers/issues/new/choose), or submit a
[pull request](https://github.com/symas/containers/pulls) with your contribution.


## License

Copyright &copy; 2023 VMware, Inc.
Copyright &copy; 2023 Symas, Corp.

Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License.

You may obtain a copy of the License at

<http://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing, software distributed
under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
CONDITIONS OF ANY KIND, either express or implied. See the License for the
specific language governing permissions and limitations under the License.
