# ComicRack - Docker

This is an attempt to dockerize the now abandonded ComicRack application. I didn't want to spin up a dedicated windows desktop - licensing and patching an entire OS for a never-to-be updated w32 app seems overkill.

Unfortunately, there's an entire other challenge for getting Wine, KasmVNC, and a severly outdated .NET application to work in a docker container.

I've enlisted the help of the linuxserver.io KasmVNC base image to handle the VNC portion, then installed WineHD on top of that. With that working, I turned my attention to the ComicRack portion by creating a rw folder mount to `/config/.wine32`, installing ComicRack, then copying the wine prefix to the `/root/config/.wine32` directory to be copied over at new container build time.

## Helpful Links

- [Overview](docs/overview.md) for more
information on how/why I did this.
- [Getting Started](docs/getting_started.md) for how to use this project
- [To Do](docs/todo.md) for what's coming up next/development priorities.