# Supported LXC Containers, by Symas Corp.

## What's here?

[OpenLDAP](https://openldap.org) and related software, provided by
[Symas](https://symas.com), containerized and ready for production use.


## How to contact Symas for commercial support

If you've not tried running your container with `SYMAS_DEBUG` set to `true` then you might try that first, this container is primed to give you the information you need to debug issues yourself.  Also, please take a look at our [knowledge base](https://kb.symas.com/) if going to the [OpenLDAP site](https://openldap.org/) and reading the [documentation](https://openldap.org/doc/), the [quick start guide](https://openldap.org/doc/admin26/quickstart.html), and the detailed [manual pages](https://openldap.org/software/man.cgi) didn't help.  [What we publish](https://repo.symas.com) is what we provide inside the [containers](https://github.com/symas/containers) we provide to you, everything is open-source.

Of course, you can always call us at: +1.650.963.7601 or email [sales](mailto:sales@symas.com) or [support](mailto:support@symas.com) teams directly with questions.  More on our support offerings can be [found on our website](https://www.symas.com/symas-tech-support).  We're also available on the Symas Discord [#openldap](https://discord.gg/t6upYQDx2) channel and chat with us directly.

Reach out to us, we're here to help.


## Why use our images?

* Symas has, for over a decade, built, maintained, and commercially supported
  the OpenLDAP codebase.
* All our work on OpenLDAP has always been, and will always be open-source.  We
  are a [commercial support company](mailto:support@symas.com), here if and when
  you need us.
* We commit to promptly publish new versions of this chart for every release of
  the software going forward.
* Our images contain the latest bug fixes and features released, not just in OpenLDAP
  but in supporting libraries.
* We've based our containers on the amazing [Bitnami
  containers](https://github.com/bitnami/containers/) existing work.
* We'd like to thank them for open sourcing their work allowing the community to
  benefit.  Our shared philosophy makes us stronger.
* Because we are using the Bitnami container infrastructure and scripts this is
  a drop-in replacement for any existing use of the `bitnami/openldap`
  containers sharing the same version.
* We base our images on Bitnami's [minideb](https://github.com/bitnami/minideb)
  a minimalist Debian-based container image that gives you a small base
  container image and the familiarity of a leading Linux distribution.


## Why not just contribute to Bitnami?

We may eventually merge our work into Bitnami, for now we'd like to remain agile
enough to build for platforms they don't (yet) support, like `arm64`, and to use
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


## Symas Packaged OpenLDAP

We, at Symas, contribute to and maintain the [OpenLDAP software](https://openldap.org) as open source software.  We work within the community of contributors to this project, that's how open source works.  We don't sell licenses to the software, the software is free for anyone to use.  We do provide commercial support for OpenLDAP, and in that capacity we've run across bugs that others may not have encountered.  We fix those issues and contribute them back to OpenLDAP through the community process.  Sometimes we find bugs impacting OpenLDAP in supporting libraries, and in those cases we fix those issues and offer them to the package maintainers.  When that process isn't fast enough, we apply our fixes to a fork of the package and include that within our package of OpenLDAP.  When that fix is upstreamed and released, we return to using the community provided library.  All that is to say that it is possible that the Symas supplied packages include fixes that are not available in other builds of OpenLDAP unless those builds included our forks of those dependencies.

In addition, Symas sometimes includes packages or configuration by default that we've found useful to our customers.


## Get an image

The recommended way to get any of the Symas LXC containers is to pull the
prebuilt image from the [Docker Hub Registry](https://hub.docker.com/r/symas/).

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
