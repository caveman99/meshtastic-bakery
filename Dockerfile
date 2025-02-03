FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=C.UTF-8
ENV PIP_BREAK_SYSTEM_PACKAGES=1
USER root

RUN apt-get update && apt-get install --no-install-recommends -y wget python3 python3-pip python3-wheel python3-venv zip git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* && mkdir /tmp/firmware

RUN bash -o pipefail -c "pip3 install --no-cache-dir -U platformio adafruit-nrfutil poetry meshtastic"
RUN groupadd -g 1000 mesh && useradd -ml -u 1000 -g 1000 mesh && chown mesh:mesh /tmp/firmware
USER mesh

WORKDIR /tmp/firmware
COPY --chown=mesh:mesh . /tmp/firmware

CMD [ "bash",  "-cx", "./bin/build-firmware.sh ${PIO_ENV} ${PIO_ARCH}" ]
