FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

ARG DEBIAN_FRONTEND=noninteractive
ARG WINE_GECKO_VERSION=2.40
ARG WINE_MONO_VERSION=4.5.6

ENV \
    HOME="/config" \
    TITLE="ComicRack" \
    WINEARCH=win32 \
    DISABLE_IPV6="true"

RUN \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    wget

RUN \
    echo "**** adding i386 arch ****" && \
    dpkg --add-architecture i386  && \
    echo "**** adding winehq sources ****" && \
    wget -O /etc/apt/sources.list.d/winehq-jammy.sources https://dl.winehq.org/wine-builds/ubuntu/dists/jammy/winehq-jammy.sources && \
    mkdir -pm755 /etc/apt/keyrings && \
    wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && \
    echo "**** install packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
       winehq-stable \
       winetricks

COPY /root /
COPY --chown=abc:abc /wine32 /wine32

