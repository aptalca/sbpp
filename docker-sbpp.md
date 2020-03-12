# [linuxserver/sbpp](https://github.com/linuxserver/docker-sbpp)

[![GitHub Stars](https://img.shields.io/github/stars/linuxserver/docker-sbpp.svg?style=flat-square&color=E68523&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver/docker-sbpp)
[![GitHub Release](https://img.shields.io/github/release/linuxserver/docker-sbpp.svg?style=flat-square&color=E68523&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver/docker-sbpp/releases)
[![GitHub Package Repository](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=GitHub%20Package&logo=github&logoColor=FFFFFF)](https://github.com/linuxserver/docker-sbpp/packages)
[![GitLab Container Registry](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=GitLab%20Registry&logo=gitlab&logoColor=FFFFFF)](https://gitlab.com/Linuxserver.io/docker-sbpp/container_registry)
[![Quay.io](https://img.shields.io/static/v1.svg?style=flat-square&color=E68523&label=linuxserver.io&message=Quay.io)](https://quay.io/repository/linuxserver.io/sbpp)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/linuxserver/sbpp.svg?style=flat-square&color=E68523)](https://microbadger.com/images/linuxserver/sbpp "Get your own version badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/linuxserver/sbpp.svg?style=flat-square&color=E68523&label=pulls&logo=docker&logoColor=FFFFFF)](https://hub.docker.com/r/linuxserver/sbpp)
[![Docker Stars](https://img.shields.io/docker/stars/linuxserver/sbpp.svg?style=flat-square&color=E68523&label=stars&logo=docker&logoColor=FFFFFF)](https://hub.docker.com/r/linuxserver/sbpp)
[![Build Status](https://ci.linuxserver.io/view/all/job/Docker-Pipeline-Builders/job/docker-sbpp/job/master/badge/icon?style=flat-square)](https://ci.linuxserver.io/job/Docker-Pipeline-Builders/job/docker-sbpp/job/master/)
[![](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/sbpp/latest/badge.svg)](https://lsio-ci.ams3.digitaloceanspaces.com/linuxserver/sbpp/latest/index.html)

[Sbpp](https://github.com/drizuid/sbpp) Global admin, ban, and communication management system for the Source engine.

## Supported Architectures

Our images support multiple architectures such as `x86-64`, `arm64` and `armhf`. We utilise the docker manifest for multi-platform awareness. More information is available from docker [here](https://github.com/docker/distribution/blob/master/docs/spec/manifest-v2-2.md#manifest-list) and our announcement [here](https://blog.linuxserver.io/2019/02/21/the-lsio-pipeline-project/).

Simply pulling `linuxserver/sbpp` should retrieve the correct image for your arch, but you can also pull specific arch images via tags.

The architectures supported by this image are:

| Architecture | Tag |
| :----: | --- |
| x86-64 | amd64-latest |
| arm64 | arm64v8-latest |
| armhf | arm32v7-latest |


## Usage

Here are some example snippets to help you get started creating a container from this image.

### docker

```
docker create \
  --name=sbpp \
  -e PUID=1000 \
  -e PGID=1000 \
  -e REMOVE_SETUP_DIRS=true or false \
  -p 8080:80 \
  -v <path to sbpp data>:/config \
  --restart unless-stopped \
  linuxserver/sbpp
```


### docker-compose

Compatible with docker-compose v2 schemas.

```yaml
version: "3"
services:
  sbpp:
    image: linuxserver/sbpp:latest
    container_name: sbpp
    restart: always
    depends_on:
      - mariadb
    volumes:
      - <path to data>:/config
    environment:
      - REMOVE_SETUP_DIRS=< true or false >
      - PGID=1000
      - PUID=1000
    ports:
      - "80:80"

```

## Parameters

Docker images are configured using parameters passed at runtime (such as those above). These parameters are separated by a colon and indicate `<external>:<internal>` respectively. For example, `-p 8080:80` would expose port `80` from inside the container to be accessible from the host's IP on port `8080` outside the container.

### Ports (`-p`)

| Parameter | Function |
| :----: | --- |
| `80` | SBPP  Web UI |


### Environment Variables (`-e`)

| Env | Function |
| :----: | --- |
| `PUID=1000` | for UserID - see below for explanation |
| `PGID=1000` | for GroupID - see below for explanation |
| `REMOVE_SETUP_DIRS=true or false` | true for existing setup false for new. |

### Volume Mappings (`-v`)

| Volume | Function |
| :----: | --- |
| `/config` | Contains your config files and data storage for SBPP |


## Optional Parameters

This container also generates an SSL certificate and stores it in
```
/config/keys/cert.crt
/config/keys/key.crt
```
To use your own certificate swap these files with yours. To use SSL forward your port to 443 inside the container IE:

```
-p 443:443
```

The application accepts a series of environment variables to further customize itself on boot:

| Parameter | Function |
| :---: | --- |
| `-e APP_TIMEZONE=` | The timezone the application will use IE US/Pacific|
| `-e APP_ENV=` | Default is production but can use testing or develop|
| `-e APP_DEBUG=` | Set to true to see debugging output in the web UI|
| `-e APP_LOCALE=` | Default is en set to the language preferred full list [here][localesurl]|
| `-e MAIL_PORT_587_TCP_ADDR=` | SMTP mailserver ip or hostname|
| `-e MAIL_PORT_587_TCP_PORT=` | SMTP mailserver port|
| `-e MAIL_ENV_FROM_ADDR=` | The email address mail should be replied to and listed when sent|
| `-e MAIL_ENV_FROM_NAME=` | The name listed on email sent from the default account on the system|
| `-e MAIL_ENV_ENCRYPTION=` | Mail encryption to use IE tls |
| `-e MAIL_ENV_USERNAME=` | SMTP server login username|
| `-e MAIL_ENV_PASSWORD=` | SMTP server login password|



## User / Group Identifiers

When using volumes (`-v` flags), permissions issues can arise between the host OS and the container, we avoid this issue by allowing you to specify the user `PUID` and group `PGID`.

Ensure any volume directories on the host are owned by the same user you specify and any permissions issues will vanish like magic.

In this instance `PUID=1000` and `PGID=1000`, to find yours use `id user` as below:

```
  $ id username
    uid=1000(dockeruser) gid=1000(dockergroup) groups=1000(dockergroup)
```

## Application Setup

Access the webui at `<your-ip>:80`, for more information check out [Sbpp](https://github.com/drizuid/sbpp).



## Support Info

* Shell access whilst the container is running:
  * `docker exec -it sbpp /bin/bash`
* To monitor the logs of the container in realtime:
  * `docker logs -f sbpp`
* Container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' sbpp`
* Image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sbpp`

## Versions

* **03.11.20:** - Initial Release.
