# ComicRack - Docker

This is an attempt to dockerize the now abandonded ComicRack application. I didn't want to spin up a dedicated windows desktop - licensing and patching an entire OS for a never-to-be updated w32 app seems overkill.

Unfortunately, there's an entire other challenge for getting Wine, KasmVNC, and a severly outdated .NET application to work in a docker container.

I've enlisted the help of the linuxserver.io KasmVNC base image to handle the VNC portion, then installed WineHD on top of that. With that working, I turned my attention to the ComicRack portion by creating a rw folder mount to `/config/.wine32`, installing ComicRack, then copying the wine prefix to the `/root/config/.wine32` directory to be copied over at new container build time.

## Usage

See [Getting Started](docs/getting_started.md) for more usage details.

## Building from scratch (Don't do this)

1. Edit the Docker file
2. Make a `wine32` directory in the repo, then run docker mounting only the `$(pwd)/wine32` to `/config/.wine32`.
3. in the web browser, manually run winetricks to download dotnet45, and then install comicrack itseslf. (this will populate your host's `wine32` directory.
4. move the `$(pwd)/wine32` to `$(pwd)/root/config/.wine32` and boot again - comicrack should be installed.

## To Do

- Persistence! I haven't figured out how to manage the database, so settings may not persist.
- Scripts/plugins (see above). I also haven't figured out the best way to handle getting scripts/plugins into the container.
- More Documentation (MariaDB backups, script/plugin installation, SOP for updating the container, etc)
- Move the ComicRack wine prefix to a different mount point, but still maintain symlinks to `/config` to allow for
  volume mounts (this may require some additional files in `/root/etc/cont-init.d`) The end goal would be to allow for a
  singular volume mount `/path/to/comicrack/config:/config` without clobbering the existing wine prefix at `/config/.wine32`
