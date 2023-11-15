# To Do

This page keeps tabs on what I'm planning/current state of things for improvements. Priority is roughly from highest to
lowest.

- [ ] Adding Comic Vine scraping support
- [ ] General Scripts/Plugins support and documentation
- [ ] Moving the wine32 prefix to something outside of `/config` to help standardize on the LinuxServer container model
- [ ] Adding community fixes (rar5, etc)
- [ ] Documentation on backing up the ComicVine Database, and restoring it.
- [ ] Documentation/testing on importing an existing ComicVine database (not from this project)
- [ ] Better tagging for dockerhub container
- [ ] Other misc export/import for things like `ComicRack.xml`

## Notes

Currently, the wine prefix is in `/config/.wine32` - and this directory is blown away with the standard LinuxServer
`/path/to/config:/config` volume mount. When we move the installation, it will require a fresh Docker image build, and
possibly some additional scripts in `/root/etc/cont-init.d` to allow for a
  singular volume mount `/path/to/comicrack/config:/config` while still allowing for the `roaming`, `local`, and any
  other critical wine directories to be mounted.
