FROM postgres:latest

ENV PATH="${PATH}:/opt"

RUN apt update -y && apt install -y \
    postgresql-client

COPY ./rootfs /

# not necessary, but for sake of clarity
CMD ["postgres"]
