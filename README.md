# DSMR-reader - Docker Compose

Derived from [xirixiz/dsmr-reader-docker](https://github.com/xirixiz/dsmr-reader-docker), this repository was created
to simplify docker compose v2 setup.

This setup is tested with a fresh installation of a Raspberry Pi 3 Model B, using the Raspberry Pi OS Lite (32-bit)
image (no
desktop environment).

## 🧰 How to use

### 📦 Images

- [DSMR-reader - Docker](https://github.com/xirixiz/dsmr-reader-docker) » xirixiz/dsmr-reader-docker:arm32v7-5.8.0-2022.09.02
- [PostgreSQL](https://hub.docker.com/_/postgres) » postgres:14-alpine
- [Database backup](https://hub.docker.com/r/tiredofit/db-backup) » tiredofit/db-backup:3.4.1
    - [Customised Dockerfile](./docker/db-backup/Dockerfile) with post webhook script
      including [rotate-backups](https://pypi.org/project/rotate-backups/), [discord.sh](https://github.com/ChaoticWeg/discord.sh) for notifications (optional) and AWS S3 sync (optional).

### ‼ Prerequisites

This requires installation of docker and docker compose on the device. Either follow installation guide
from [Docker](https://docs.docker.com/desktop/install/linux-install/) or use
the guide below.

<details>
  <summary>🐋 Docker</summary>

Setup docker using the following commands.

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

> Note: We are using `linux/raspbian` for a Raspberry Pi 3 Model B.

> Note: We are going to install the docker compose plugin separately as history has shown
> that [releases of docker compose
> generally depend on releases of Docker CLI](https://github.com/docker/compose/issues/9657#issuecomment-1200318451).

</details>
<details>
  <summary>🐳 Docker Compose</summary>

Setup docker compose using the following commands.

```shell
DOCKER_COMPOSE_VERSION=v2.17.3
mkdir -p ~/.docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-linux-armv7 -o ~/.docker/cli-plugins/docker-compose
chmod +x ~/.docker/cli-plugins/docker-compose
```

> Note: We are using `docker-compose-linux-armv7` here for our Raspberry Pi 3 Model B. You can check this
> with `uname -a`.
</details>

## 📝 Setup

1. Clone/download this repository.
2. Copy the `.env.example` to `.env` and edit the values where needed.
    * For security reasons please change at least the following variables:
        * `POSTGRES_PASSWORD`
        * `DSMRREADER_ADMIN_PASSWORD`
3. By default, the devices mounted to the DSMR service in the docker compose config is set to `/dev/ttyUSB0`. If
   this differs on your device, please change this before continuing.
    * If you are not sure which `ttyUSB` it is, you can easily check this by plugging in the P1 cable into your
      Raspberry Pi and see which `ttyUSB` was added in the `/dev` directory (`ls /dev/tty*`).
4. Up the stack.
   ```
   docker compose up -d
   ```

You should now be able to visit the dashboard at `http://xxx.xxx.xxx.x:7777`.

## ❕️ License

Distributed under the MIT License. See [LICENSE](./LICENSE) for more information.