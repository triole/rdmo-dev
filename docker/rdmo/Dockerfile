FROM alpine:latest

ARG UID GID

ENV USER=usr
ENV GROUP=grp
ENV HOME=/home/usr
ENV UID="${UID}"
ENV GID="${GID}"
ENV PATH="${PATH}:${HOME}/.local/bin:${HOME}/sh:/vol/shed:/vol/mybins"

RUN apk add --no-cache --update bash curl g++ gcc git grep procps musl-dev net-tools
RUN apk add --no-cache --update python3 py3-pip python3-dev gettext
RUN rm "$(find /usr/lib -type f -regex ".*python.*EXTERNALLY-MANAGED.*")"

RUN pip3 install --upgrade pip
RUN pip3 install --upgrade wheel
RUN pip3 install --upgrade setuptools

RUN pip3 install pytest
RUN pip3 install django-allauth
RUN pip3 install pytz
RUN pip3 install tzdata

RUN apk add --no-cache --update postgresql-client
RUN apk add --no-cache --update libpq-dev
RUN pip3 install psycopg2

RUN rm -f /usr/bin/python
RUN ln -s /usr/bin/python3 /usr/bin/python

COPY ./rootfs /
RUN curl --output ${HOME}/.bashrc \
  https://raw.githubusercontent.com/triole/ghwfe/master/bashrc/default.sh

RUN addgroup -g "${GID}" -S "${GROUP}"
RUN adduser -S "${USER}" -u "${UID}" -G "${GROUP}" -h "${HOME}" -s "/bin/sh"
RUN chown -R "${USER}:${GID}" "${HOME}" /var/log
RUN chmod -R 755 "/home"

HEALTHCHECK --interval=30s --timeout=5s --retries=3 \
CMD webra /healthcheck.toml

RUN chmod 755 /drun.sh
USER "${USER}"
CMD ["/drun.sh"]
