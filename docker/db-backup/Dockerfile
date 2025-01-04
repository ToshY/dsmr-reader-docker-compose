ARG DB_BACKUP_IMAGE_VERSION

FROM tiredofit/db-backup:${DB_BACKUP_IMAGE_VERSION:-4.0.35}

ARG DISCORD_SH_VERSION=${DISCORD_SH_VERSION:-v2.0.0}

RUN set -ex \
    && apk update  \
    && apk upgrade \
    && apk add --no-cache tzdata curl wget jq py3-pip file \
    && pip3 install rotate-backups --break-system-packages

COPY ./config/notification.sh /assets/scripts/post/notification.sh

RUN set -ex \
    && wget -O /tmp/z.$$ --secure-protocol=TLSv1_3 https://github.com/fieu/discord.sh/archive/refs/tags/$DISCORD_SH_VERSION.zip \
    && unzip -d /usr/bin/discord -j -o /tmp/z.$$ \
    && rm /tmp/z.$$ \
    && chmod +x /assets/scripts/post/notification.sh /usr/bin/discord/discord.sh
