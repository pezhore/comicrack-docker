# Overview


I have been working on dockerizing a favorite piece of abandonware. And I have good news!

Release v0.0.1.a-pre (e.g. the first working-ish version) has been released and incredibly unthoroughly tested! 

There are several [visual issues](ui_issues.png), and since the container exposes KasmVNC over https, putting it behind an Nginx reverse proxy makes [Firefox upset](firefox_issues).

### Method

I'm using a [`docker-compose.yml`](../docker-compose.yml) file to spin up both my container and a compatible MariaDB container on a dedicated docker network. MariaDB's port isn't exposed in that `docker-compose.yml` file - specifically since it is an outdated install.


### TBD/Needs Testing

- Scripts/plugins/etc - I haven't added any so far, my goal was just get it running. Installation of scripts and testing is currently out of scope (but is high on my priority list)
- Broader testing - It Works On My PC^TM - but what about your setup? I don't know, but I'd like to know! I'll be looking for feedback on the installation process/bugs (no guarantees I can fix them, but I'll try)
- Documentation - I'd like to make this as painless as possible to get started, but it's already a bit of a mess (there's a whole pre-seed mariadb sql file thing). Ideally, I'd like to get to a scripted install, but even if it can just be documented enough to capture edge cases, how to add scripts, etc - I'd be happy there.

### Why Dockerize ComicRack?

I love(d) ComicRack - I was a paying member back when such a thing was possible. As you can see from the screenshot above, I have one or two comics and finding a comprehensive tagging/organizer that is *currently* supported is basically impossible. There's a few reasons for dockerizing this:

1. I didn't want to spin up a dedicated Windows desktop just to run this software - that's a whole separate patching/managing issue that I would rather not deal with.
2. One redditor asked why dockerize if ComicRack isn't getting updated anymore - that's in my opinion a really good reason to dockerize, once it works, there's no additional patching/testing/building required. Get a working image and call it a day (provided the underlying KasmVNC base doesn't need security updates).
3. I wanted to run this on my Proxmox Docker Host virtual machine - I have several other containers running on a headless server, dumping this on the same VM just made sense.
4. Distribution/setup - when I can get this fully documented, it *should* be easier to just run a docker container with the appropriate mounts and call it a day. Maybe I can burn in to the container some of the most common scripts? Regardless, for those people who don't have or want a spare Windows VM, this should help get them started.

### Why did you ____?

- Use MariaDB vs Built-in XML db, vs MySQL?
    - I wanted to keep everything containerized and unfortunately, the LinuxServer container for MySQL seems abandoned. I also liked the LinuxServer MariaDB support of a "first run" [sql file](https://github.com/pezhore/comicrack-docker/blob/main/docs/init_comicdb.sql) to ensure the proper ComicRack DB/user/privileges are in place.
- Use wine vs making a Windows container?
   - Currently, Windows containers can only run on windows - and I didn't want the overhead of maintaining a Windows system (see above). Plus, if I was running Windows for containers - I would probably just install ComicRack directly and call it a day.
- Use wine in a container vs wine directly on Linux?
   - I could have - and frankly, if the 5 day effort to dockerize hadn't panned out, I probably would have used my Ubuntu Laptop + wine instead.

### What's next?

Try it out by visiting the [getting started](getting_started.md) page. If you have issues, open one and I'll do my best
to address it.

If you have a feature request, open an issue and I'll see what I can do. I'm not a .NET developer, so I can't promise
anything other than what I can cobble together with docker.

Keep track of the [todo](./todo.md) list to see what's coming up/priorities.