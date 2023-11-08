FROM ghcr.io/linuxserver/baseimage-kasmvnc:ubuntujammy

ARG DEBIAN_FRONTEND=noninteractive
ARG WINE_GECKO_VERSION=2.40
ARG WINE_MONO_VERSION=4.5.6

ENV \
    HOME="/config" \
    TITLE="ComicRack" \
    WINEPREFIX=/config/.wine \
    WINEARCH=win32 \
    CUSTOM_PORT="9080" \
    DISABLE_IPV6="true" \
    QTWEBENGINE_DISABLE_SANDBOX="1"

RUN \
  echo "**** install runtime packages ****" && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    dbus \
    fcitx-rime \
    fonts-wqy-microhei \
    libnss3 \
    libopengl0 \
    libqpdf28 \
    libxkbcommon-x11-0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xinerama0 \
    poppler-utils \
    python3 \
    python3-xdg \
    ttf-wqy-zenhei \
    wget \
    xz-utils \
    vim-gtk3

RUN \
    echo "**** adding i386 arch ****" && \
    dpkg --add-architecture i386

RUN \
    echo "**** install packages ****" && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        wget \
        software-properties-common \
        wine \
        winetricks \
        xvfb \
        winbind

RUN \
    echo "**** creating directories ****" && \
    mkdir -p /usr/share/wine/gecko \
             /usr/share/wine/mono \
             /tmp/.X11-unix && \
    chmod 1777 /tmp/.X11-unix

RUN \
    echo "**** download msi files ****" && \
    wget "http://dl.winehq.org/wine/wine-gecko/${WINE_GECKO_VERSION}/wine_gecko-${WINE_GECKO_VERSION}-x86.msi" \
            -O /usr/share/wine/gecko/wine_gecko-${WINE_GECKO_VERSION}-x86.msi && \
    wget "http://dl.winehq.org/wine/wine-gecko/${WINE_GECKO_VERSION}/wine_gecko-${WINE_GECKO_VERSION}-x86_64.msi" \
            -O /usr/share/wine/gecko/wine_gecko-${WINE_GECKO_VERSION}-x86_64.msi && \
    wget "http://dl.winehq.org/wine/wine-mono/${WINE_MONO_VERSION}/wine-mono-${WINE_MONO_VERSION}.msi" \
            -O /usr/share/wine/mono/wine-mono-${WINE_MONO_VERSION}.msi

COPY /root /
