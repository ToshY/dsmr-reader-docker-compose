ARG DB_BACKUP_IMAGE_VERSION

FROM tiredofit/db-backup:${DB_BACKUP_IMAGE_VERSION}

ARG DISCORD_SH_VERSION=${DISCORD_SH_VERSION:-v1.6.1}

RUN set -ex \
    && apk update  \
    && apk upgrade \
    && apk add --no-cache tzdata curl jq py3-pip \
    && pip3 install rotate-backups

COPY ./config/notification.sh /assets/scripts/post/notification.sh

RUN set -ex \
    && wget -O /tmp/z.$$ https://github.com/ChaoticWeg/discord.sh/archive/refs/tags/$DISCORD_SH_VERSION.zip \
    && unzip -d /usr/bin/discord -j -o /tmp/z.$$ \
    && rm /tmp/z.$$ \
    && chmod +x /assets/scripts/post/notification.sh /usr/bin/discord/discord.sh
