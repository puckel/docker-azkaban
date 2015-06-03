## Azkaban Dockerfiles
Azkaban is a batch workflow job scheduler created at LinkedIn to run Hadoop jobs. Azkaban resolves the ordering through job dependencies and provides an easy to use web user interface to maintain and track your workflows.
Azkaban consists of 3 key components:

- Relational Database (MySQL)
- AzkabanWebServer
- AzkabanExecutorServer

This repository contains **Dockerfiles** of [Azkaban](http://azkaban.github.io/) for [Docker](https://www.docker.com/).


### Base Docker Image
* Official [java:8](https://registry.hub.docker.com/_/java/)


### Installation
1. Install [Docker](https://www.docker.com/).

2. Install [Docker-compose](https://docs.docker.com/compose/install/).

3. Download automated builds

[azkaban-webserver](https://registry.hub.docker.com/u/puckel/azkaban-webserver/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull puckel/docker-azkaban-webserver`

[azkaban-executor](https://registry.hub.docker.com/u/puckel/azkaban-executor/) from public [Docker Hub Registry](https://registry.hub.docker.com/): `docker pull puckel/docker-azkaban-executor`

Alternatively, you can build an image from [Dockerfile](https://github.com/puckel/docker-azkaban).


### Usage
```bash
docker-compose up -d
docker-compose ps
```

The repository contains a shell script to test the azkaban stack: testing/test_api.sh (require [jq](https://stedolan.github.io/jq/)).
