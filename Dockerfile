FROM python:3.10-slim-bullseye

RUN DEBIAN_FRONTEND=noninteractive apt update \
    && apt install -yqq \
    bash \
    curl \
    dnsutils \
    proxychains-ng \
    tor \
    tor-geoipdb

COPY torrc /etc/tor/torrc
COPY resolv.conf /etc/resolv.conf
COPY proxychains.conf /etc/proxychains.conf

WORKDIR /app

ADD DDoS-Ripper/DRipper.py DDoS-Ripper/headers.txt docker_entrypoint.sh ./

ENTRYPOINT ["./docker_entrypoint.sh"]
