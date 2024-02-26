# ⚡ DSMR-reader - Docker Compose

Derived from [xirixiz/dsmr-reader-docker](https://github.com/xirixiz/dsmr-reader-docker), this repository was created
to simplify docker compose v2 setup.

This setup is tested with a fresh installation of a Raspberry Pi 3 Model B, using the Raspberry Pi OS Lite (32-bit)
image (no
desktop environment).

## 🧰 Getting Started

### ‼️ Prerequisites

* [Docker (Compose) Raspberry Pi OS](https://docs.docker.com/engine/install/raspberry-pi-os/)
* [Task (3.15+)](https://taskfile.dev/installation/) (optional, but recommended)

### 📦 Images

- [DSMR-reader - Docker](https://github.com/xirixiz/dsmr-reader-docker)
- [PostgreSQL](https://hub.docker.com/_/postgres)
- [Database backup](https://hub.docker.com/r/tiredofit/db-backup)
    - [Customised Dockerfile](./docker/db-backup/Dockerfile) with post webhook script
      including [rotate-backups](https://pypi.org/project/rotate-backups/) and [discord.sh](https://github.com/ChaoticWeg/discord.sh); allows for notifications and AWS S3 sync (both optional).

## 📝 Setup

1. Clone/download this repository.
2. Copy the `.env.example` to `.env` and edit the values where needed.
    ```shell
    task dotenv
    ```
    > For security reasons please change at least the following variables:
    >   * `POSTGRES_PASSWORD`
    >   * `DSMRREADER_ADMIN_PASSWORD`
3. By default, the devices mounted to the DSMR service in the docker compose config is set to `/dev/ttyUSB0`. If
   this differs on your device, please change this before continuing.
    * If you are not sure which `ttyUSB` it is, you can easily check this by plugging in the P1 cable into your
      Raspberry Pi and see which `ttyUSB` was added in the `/dev` directory (`ls /dev/tty*`).
4. Up the stack.
   ```shell
   task up
   ```

You should now be able to visit the dashboard at `http://xxx.xxx.xxx.x:7777`.

### 💾 Database

#### Restore

You can restore database backups with the interactive `restore` script.

```shell
docker compose exec -it postgres-backup restore
```

## ❕️ License

Distributed under the MIT License. See [LICENSE](./LICENSE) for more information.