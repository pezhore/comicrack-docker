# Getting Started

This assumes you are running a modern Linux distro with Docker installed/configured and `docker-compose` installed. Some
familiarity with Docker is assumed.

There are two paths to get started - one is to clone this repo and build the image yourself, the other is to leverage
Docker Hub and creating the `docker-compose.yml` and supplemental files yourself.

## Option 1: Clone and Build

1. Clone the repo
2. Build the docker image: `docker build -t comicrack .`
3. Create an appropriate folder (outside the repo as to not confuse/anger the git gods). `/opt/comicrack` is a good
   choice and is assumed for the rest of this guide.
4. Follow the steps for Option 2 below

## Option 2: Docker Hub
1. Create a `docker-compose.yml` file in an appropriate folder (this guide uses `/opt/comicrack`). See below for an
   example `docker-compose.yml`.
   
   **NOTE:** You'll want to update your comics directory and the PUID/PGID to reflect your user/group ID. You can find
   those IDs by running `id` in a terminal.
    ```yaml
    version: "2.1"
    services:
    mariadb:
        image: lscr.io/linuxserver/mariadb:10.5.17
        container_name: mariadb
        environment:
        - PUID=1024
        - PGID=1000
        - TZ=Etc/UTC
        volumes:
        - /opt/comicrack/mariadb:/config
        expose:
        - "3306"
        restart: unless-stopped
        networks:
        - comicrack
    comicrack:
        image: pezhore/comicrack:latest
        container_name: comicrack
        depends_on:
        - mariadb
        environment:
        - PUID=1024
        - PGID=1000
        - TZ=Etc/UTC
        volumes:
        - /opt/comicrack/local:/config/local
        - /opt/comicrack/roaming:/config/roaming
        - /path/to/comics:/config/comics
        ports:
        - 9001:3001
        networks:
        - comicrack
    networks:
    comicrack:
        name: comicrack
    ```
2. Create the first run MariaDB folder `/opt/comicrack/mariadb/initdb.d` and copy the
   [`init_comicdb.sql`](./init_comicdb.sql) file from the repo into it.
3. Run `docker-compose up -d` to start the containers.
4. Open a browser and navigate to `https://<server ip>:9001` to access the web interface.
   **NOTE:** The first run may result in ComicRack coming up before MariaDB does its full initialization. If so, wait
   until the docker logs indicate MariaDB has finished its setup and then issue the `docker-compose restart comicrack`
   command.