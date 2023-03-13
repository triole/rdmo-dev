FROM postgres:latest

ENV HOME="/root"
ENV PATH="${PATH}:/opt:/vol/shed:/vol/bin"

ENV PATH=${PATH}:${HOME}/sh

RUN apt update -y && apt install -y \
    curl postgresql-client

RUN mkdir -p ${HOME}/sh
RUN curl --output ${HOME}/.bashrc \
    https://raw.githubusercontent.com/triole/ghwfe/master/bashrc/default.sh

COPY ./sh/* ${HOME}/sh/

# not necessary, but for sake of clarity
CMD ["postgres"]
