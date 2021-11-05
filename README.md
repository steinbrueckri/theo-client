# Theo-Client

[![Dependabot Status](https://api.dependabot.com/badges/status?host=github&repo=steinbrueckri/theo-client)](https://dependabot.com)
![test-build-release](https://github.com/steinbrueckri/theo-client/workflows/test-build-release/badge.svg)
![Docker Image Version (latest semver)](https://img.shields.io/docker/v/steinbrueckri/theo-client)
![Docker Pulls](https://img.shields.io/docker/pulls/steinbrueckri/theo-client)
![Docker Image Size (latest semver)](https://img.shields.io/docker/image-size/steinbrueckri/theo-client)

## Why

Container to run the [theo-cli](https://github.com/theoapp/theo-cli) on Kubernetes cluster.

### Build locally

```sh
make dev-build
```

### Run in docker context

```sh
docker run -d --rm -p2222:22 -e THEO_URL="http://xxx" -e THEO_CLIENT_TOKEN="xxx" -e THEO_ADMIN_TOKEN="xxx" steinbrueckri/theo-client
```

### Run in K8s context

see [https://github.com/p1nkun1c0rns/charts](https://github.com/p1nkun1c0rns/charts) for installation via Helm.

## Configuration

### Environment variables

- `THEO_URL`
- `THEO_ADMIN_TOKEN`
- `THEO_CLIENT_TOKEN`

## Contributions

- Contributions are welcome!
- Give :star: - if you want to encourage me to work on a project
- Don't hesitate create issue for new feature you dream of or if you suspect some bug

## Testing

For testing the [bats](https://github.com/bats-core/bats-core#installation) testing framework is used.

```bash
git clone https://github.com/steinbrueckri/theo-client.git
./tests/run.bats
```

## Project versioning

Project use [Semantic Versioning](https://semver.org/).
We recommended to use the latest and specific release version.

In order to keep your project dependencies up to date you can watch this repository *(Releases only)*
or use automatic tools like [Dependabot](https://dependabot.com/).

## Release

- create new branch
- make your changes, if needed
- commit your changes like
  - Patch Release: `fix(script): validate input file to prevent empty files`
  - Minor Release: `feat(dockerimage): add open for multiple input files`
  - Major Release [look her](https://github.com/mathieudutour/github-tag-action/blob/master/README.md)
