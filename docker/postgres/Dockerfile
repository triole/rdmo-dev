FROM postgres:latest

ENV HOME="/root"
ENV PATH="${PATH}:/opt:/vol/shed:/vol/bin"

RUN apt update -y && apt install -y \
    curl postgresql-client

RUN mkdir -p ${HOME}
RUN curl --output ${HOME}/.bashrc \
    https://raw.githubusercontent.com/triole/ghwfe/master/bashrc/default.sh

# not necessary, but for sake of clarity
CMD ["postgres"]
