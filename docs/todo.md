# To Do

This page keeps tabs on what I'm planning/current state of things for improvements. Priority is roughly from highest to
lowest.

- [ ] Adding Comic Vine scraping support
- [ ] General Scripts/Plugins support and documentation
- [x] Moving the wine32 prefix to something outside of `/config` to help standardize on the LinuxServer container model
- [ ] Adding community fixes (rar5, etc)
- [ ] Documentation on backing up the ComicVine Database, and restoring it.
- [ ] Documentation/testing on importing an existing ComicVine database (not from this project)
- [ ] Better tagging for dockerhub container
- [ ] Other misc export/import for things like `ComicDB.xml`, `ComicRack.ini`, etc
- [ ] Include documentation on how to clean up trash in the container (lest you convert 9k `.cbr` files and fill up your host os's drive
- [ ] Formal, `incoming` directory mount in the `docker-compose.yml` to allow for easier script/file transfer
