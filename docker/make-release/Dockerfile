FROM alpine:latest

ARG UID GID

ENV USER=usr
ENV GROUP=grp
ENV HOME=/home/usr
ENV UID="${UID}"
ENV GID="${GID}"
ENV PATH="${PATH}:${HOME}/.local/bin:${HOME}/sh:/vol/shed:/vol/mybins"
ENV NVM_DIR="${HOME}/.nvm"

RUN apk add --no-cache --update bash curl grep
RUN apk add --no-cache --update python3 py3-pip
RUN apk add --no-cache --update nodejs npm

COPY ./make-release.sh /

RUN addgroup -g "${GID}" -S "${GROUP}"
RUN adduser -S "${USER}" -u "${UID}" -G "${GROUP}" -h "${HOME}" -s "/bin/sh"
RUN chown -R "${USER}:${GID}" "${HOME}" /var/log

USER "${USER}"
RUN curl --output ${HOME}/.bashrc \
  https://raw.githubusercontent.com/triole/ghwfe/master/bashrc/default.sh

WORKDIR ${HOME}
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.1/install.sh | bash

WORKDIR ${HOME}/rdmo
CMD ["/make-release.sh"]

