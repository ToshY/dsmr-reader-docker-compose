# DSMR-reader - Docker Compose

Derived from [xirixiz/dsmr-reader-docker](https://github.com/xirixiz/dsmr-reader-docker), this repo was created
to simplify docker compose v2 setup.

This setup is tested with Raspberry Pi 3 Model B (fresh install), using the Raspberry Pi OS Lite (32-bit) image (no desktop environment).

## How to use

### Prerequisites

This requires installation of docker and docker compose on the device. Either follow installation guide
from [Docker](https://docs.docker.com/desktop/install/linux-install/) or use
the guide below.

#### Docker

```shell
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/raspbian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/raspbian \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
```

> Note: We are using `/linux/raspbian` here for our Raspberry Pi 3 Model B.

> Note: We are going to install the docker compose plugin separately as history has shown
> that [releases of docker compose
> generally depend on releases of Docker CLI](https://github.com/docker/compose/issues/9657#issuecomment-1200318451).

#### Docker Compose

```shell
DOCKER_COMPOSE_VERSION=v2.11.2
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-armv7 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
```

> Note: We are using `docker-compose-linux-armv7` here for our Raspberry Pi 3 Model B. You can check this
> with `uname -a`.

## Prepare environment variables

Copy `.env.example` to `.env` and edit the values where needed.

## Run

You can up the stack now.

```shell
docker compose up -d
```

You should now be able to visit the dashboard at `http://xxx.xxx.xxx.x:7777`.