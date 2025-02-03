FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=C.UTF-8
USER root

RUN apt-get update && apt-get install --no-install-recommends -y wget python3 python3-pip python3-wheel python3-venv zip git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && mkdir /tmp/firmware

RUN groupadd -g 1000 mesh && useradd -ml -u 1000 -g 1000 mesh && chown mesh:mesh /tmp/firmware
USER mesh

WORKDIR /tmp/firmware
RUN bash -o pipefail -c "pip3 install --no-cache-dir --break-system-packages -U platformio adafruit-nrfutil poetry meshtastic"
COPY --chown=mesh:mesh . /tmp/firmware

CMD [ "bash",  "-cx", "./bin/build-firmware.sh ${PIO_ENV}" ]